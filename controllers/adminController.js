// controllers/adminController.js
import { getAdminDataFromDB, updateTourismAttraction, addTourismAttraction, fetchTourismAttraction, deleteTourismAttraction, fetchAnonymousUsers, getEstablishmentEnglishNames, fetchOpenEndedSurveyResponses } from '../services/adminService.js';
import logger from '../middleware/logger.js';
import { validationResult } from 'express-validator';
import pool from '../config/db.js';
import { addHFToken, getHFTokenByLabel, getHFTokens } from '../services/hfTokenService.js';
import { queryHuggingFace } from '../services/huggingFaceService.js';
import { logEmitter } from '../middleware/logger.js';
import dotenv from 'dotenv';
import { response } from 'express';
import { createLocalizationService, deleteLocalizationService, fetchLocalizationsService, updateLocalizationService } from '../services/adminCRUD.js';
dotenv.config();

export const getAdminData = async (req, res, next) => {
  logger.info("GET /api/admin/data");
  try {
    const data = await getAdminDataFromDB();
    res.json(data);
  } catch (err) {
    next(err); // Pass error to error handler
  }
};

export const addTourismAttractionController = async (req, res, next) => {
  logger.info("POST /api/admin/add");
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() }); // Validation errors are still sent directly
  }

  try {
    const newAttraction = req.body;
    const result = await addTourismAttraction(newAttraction);
    res.status(201).json(result);
  } catch (err) {
    next(err); // Pass error to error handler
  }
};

export const fetchTourismAttractionsController = async (req, res, next) => {
  logger.info("GET /api/admin/fetch");
  try {
    const attractions = await fetchTourismAttraction();
    res.json(attractions);
  } catch (err) {
    next(err);
  }
}


export const deleteTourismAttractionController = async (req, res, next) => {
  logger.info("DELETE /api/admin/delete/:id");
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const response = req.body;
    const result = await submitSurveyResponse(response);
    res.status(201).json(result);
  } catch (err) {
    console.error('Error submitting survey response:', err);
    res.status(500).json({ error: 'Failed to submit survey response' });
  }
};

export const updateTourismAttractionController = async (req, res, next) => {
  logger.info("PUT /api/admin/update/:id");
  try {
    const { id } = req.params;
    const updatedAttraction = req.body;
    const result = await updateTourismAttraction(id, updatedAttraction);
    res.json(result);
  } catch (err) {
    next(err);
  }
};

export const getAdminSessionData = async (req, res, next) => {
  logger.info("GET /api/admin/session-data");
  try {
    const result = await pool.query('SELECT username, last_login, last_logout, session_duration, is_logged_in FROM admin_table');
    res.json(result.rows);
  } catch (err) {
    next(err);
  }
};

export const posthftokens = async (req, res) => {
  logger.info("POST /api/hf-tokens");
  logger.info(req.body);
  const { apitoken, label } = req.body;
  try {
    const result = await addHFToken(apitoken, label);
    res.status(201).json({ id: result.id, label: result.label });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const gethftokens = async (req, res) => {
  try {
    const tokens = await getHFTokens();
    res.json(tokens);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const analyzeSentiment = async (req, res) => {
  logger.info("POST /api/admin/analyzesentiment");


  const text = req.body.text;
  const tokenLabel = req.body.tokenLabel;
  logger.info(`Analyzing sentiment:, ${text}`);
  logger.info(`Using API token label: ${tokenLabel}`);
  try {
    // Fetch the decrypted API token from the database using the label
    const apiToken = await getHFTokenByLabel(tokenLabel); // Ensure this function is implemented in hfTokenService.js

    if (!apiToken) {
      return res.status(400).json({ error: 'Invalid API token label' });
    }

    // Call the Hugging Face API
    const analysisResult = await queryHuggingFace(text, apiToken, process.env.BERTSENT_ENDPOINT);

    // Return the analysis result to the frontend
    res.json(analysisResult);
  } catch (err) {
    console.error('Error during analysis:', err);
    res.status(500).json({ error: 'Failed to analyze text' });
  }
};
export const analyzeTopics = async (req, res) => {
  logger.info("POST /api/admin/analyzetopics");

  const text = req.body.text;
  const tokenLabel = req.body.tokenLabel;
  logger.info(`Analyzing topics: ${text}`);
  logger.info(`Using API token label: ${tokenLabel}`);
  logger.info(`Using endpoint: ${process.env.BERTOPIC_ENDPOINT}`)
  try {
    // Fetch the decrypted API token from the database using the label
    const apiToken = await getHFTokenByLabel(tokenLabel); // Ensure this function is implemented in hfTokenService.js

    if (!apiToken) {
      return res.status(400).json({ error: 'Invalid API token label' });
    }

    const analysisResult = await queryHuggingFace(text, apiToken, process.env.BERTOPIC_ENDPOINT); 

    // Return the analysis result to the frontend
    res.json(analysisResult);
  } catch (err) {
    console.error('Error during topic analysis:', err);
    res.status(500).json({ error: 'Failed to analyze topics' });
  }
};

export const fetchAnonymousUsersController = async (req, res, next) => {
  logger.info("GET /api/admin/anonymous-users");
  try {
    const users = await fetchAnonymousUsers();
    res.json(users);
  } catch (err) {
    next(err);
  }
};
export const logstream = async (req, res, next) => {
  console.log("EVENT SOURCE LOGSTREAM");
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.setHeader('Access-Control-Allow-Origin', process.env.FRONTEND_URL); // Explicitly allow your React app's origin
  res.setHeader('Access-Control-Allow-Credentials', 'true'); // Allow credentials (if needed)

  const sendLog = (log) => {
    res.write(`data: ${JSON.stringify(log)}\n\n`);
  };

  // Listen for new logs
  logEmitter.on('log', sendLog);

  // Clean up on client disconnect
  req.on('close', () => {
    logEmitter.off('log', sendLog);
  });
};

export const getEstablishmentEnglishNamesController = async (req, res, next) => {
  logger.info("GET /api/admin/establishments");
  try {
    const englishNames = await getEstablishmentEnglishNames();
    res.json(englishNames);
  } catch (err) {
    next(err); 
};
}

export const getOpenEndedSurveyResponses = async (req, res, next) => {
  logger.info("GET /api/admin/survey-responses/open-ended");
  try {
    const responses = await fetchOpenEndedSurveyResponses();
    logger.info(JSON.stringify(responses));
    res.json(responses);
  } catch (err) {
    next(`ERROR ON SENDING A RESPONSE: ${err}`); // Pass error to error handler
  }
};


export const createLocalization = async (req, res, next) => {
  logger.info("POST /api/admin/localization");
  try {
    const { key, languagecode, textContent, component } = req.body;
    logger.warn(`CRL --- ${JSON.stringify(req.body)}`);
    // Validate required fields
    if (!key || !languagecode || !textContent || !component) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await createLocalizationService( key, languagecode, textContent, component);
    res.status(201).json(`SUCCESSFULLY INSERTED ROW`);
  } catch (err) {
    next(`ERROR ON CREATING A ROW on LOCALIZATION: ${err}`);
  }
};

export const fetchLocalization = async (req, res, next) => {
  logger.info("GET /api/admin/localization");
  try {
    const result = await fetchLocalizationsService({ });
    res.json(result);
  } catch (err) {
    next(`ERROR ON FETCHING FROM LOCALIZATION: ${err}`);
  }
};

export const updateLocalization = async (req, res, next) => {
  logger.info("PUT /api/admin/localization/:id");
  logger.warn(`CRL --- ${JSON.stringify(req.body)}`);

  try {
    const {id, key, languagecode, textContent, component } = req.body;
    // Validate required fields
    if (!id || !key || !languagecode || !textContent || !component) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await updateLocalizationService( id, key, languagecode, textContent, component );

    // Implementation will be in service layer
    res.json({ message: `Localization ${id} updated successfully` });
  } catch (err) {
    next(`ERROR ON UPDATING ROW IN LOCALIZATION: ${err}`);
  }
};

export const deleteLocalization = async (req, res, next) => {
  logger.info("DELETE /api/admin/localization/:id");
  try {
    const { id } = req.body;
    
    // Validate required fields
    if (!id) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await deleteLocalizationService( id );

    // Implementation will be in service layer
    res.json({ message: `Localization ${id} deleted successfully` });
  } catch (err) {
    next(`ERROR ON DELETING ROW FROM LOCALIZATION: ${err}`);
  }
};

export const createEstablishment = async (req, res, next) {
  
}