// controllers/adminController.js
import { getAdminDataFromDB, updateTourismAttraction, addTourismAttraction, fetchTourismAttraction, deleteTourismAttraction, fetchAnonymousUsers, getEstablishmentEnglishNames, fetchOpenEndedSurveyResponses, fetchSurveyQuestionsService } from '../services/adminService.js';
import logger from '../middleware/logger.js';
import { validationResult } from 'express-validator';
import pool from '../config/db.js';
import { addHFToken, getHFTokenByLabel, getHFTokens } from '../services/hfTokenService.js';
import { queryHuggingFace } from '../services/huggingFaceService.js';
import { logEmitter } from '../middleware/logger.js';
import dotenv from 'dotenv';
import { response } from 'express';
import { createEstablishmentService, createLocalizationService, createSentimentAnalysisService, createTourismAttractionService, deleteEstablishmentService, deleteLocalizationService, deleteSentimentAnalysisService, deleteSurveyResponseService, deleteTourismAttractionService, fetchAllTouchpointsService, fetchEstablishmentsService, fetchLocalizationsService, fetchSentimentAnalysisService, fetchSurveyResponsesService, fetchTourismAttractionsService, fetchTranslatedTouchpointService, insertTopicDataService, updateEstablishmentService, updateLocalizationService, updateSentimentAnalysisService, updateSurveyResponseService, updateTourismAttractionService } from '../services/adminCRUD.js';
import { calculateAverageCompletionTimeService, fetchAllFinishedRows, fetchAndGroupFinishedSurveyResponsesByMonthService, fetchByAgeGroup, fetchByCountryResidence, fetchByGender, fetchByNationality, fetchByTimeOfDay, fetchEntityinSurveyFeedbackService, fetchTouchpointsService, fetchUnfinishedSurveys, getAllSurveyTally, getSentimentAnalysis, groupByLikertRatingService } from '../services/analyticsCRUD.js';
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
//come back to this. not sure what frontend uses this
// export const fetchTourismAttractionsController = async (req, res, next) => {
//   logger.info("GET /api/admin/fetch");
//   try {
//     const attractions = await fetchTourismAttraction();
//     res.json(attractions);
//   } catch (err) {
//     next(err);
//   }
// }


// export const deleteTourismAttractionController = async (req, res, next) => {
//   logger.info("DELETE /api/admin/delete/:id");
//   const errors = validationResult(req);
//   if (!errors.isEmpty()) {
//     return res.status(400).json({ errors: errors.array() });
//   }

//   try {
//     const response = req.body;
//     const result = await submitSurveyResponse(response);
//     res.status(201).json(result);
//   } catch (err) {
//     console.error('Error submitting survey response:', err);
//     res.status(500).json({ error: 'Failed to submit survey response' });
//   }
// };

// export const updateTourismAttractionController = async (req, res, next) => {
//   logger.info("PUT /api/admin/update/:id");
//   try {
//     const { id } = req.params;
//     const updatedAttraction = req.body;
//     const result = await updateTourismAttraction(id, updatedAttraction);
//     res.json(result);
//   } catch (err) {
//     next(err);
//   }
// };

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
  // logger.info(req.body);
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
    // logger.info(JSON.stringify(responses));
    res.json(responses);
  } catch (err) {
    next(`ERROR ON SENDING A RESPONSE: ${err}`); // Pass error to error handler
  }
};


export const createLocalization = async (req, res, next) => {
  logger.info("POST /api/admin/localization");
  try {
    const { key, languagecode, textcontent, component } = req.body;
    logger.warn(`CRL --- ${JSON.stringify(req.body)}`);
    // Validate required fields
    const missingFields = [];
    if (!key) missingFields.push('key');
    if (!languagecode) missingFields.push('languagecode');
    if (!textcontent) missingFields.push('textcontent');
    if (!component) missingFields.push('component');

    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing required fields', ${missingFields}` });
    }

    const result = await createLocalizationService(key, languagecode, textcontent, component);
    res.status(201).json(`SUCCESSFULLY INSERTED ROW`);
  } catch (err) {
    next(`ERROR ON CREATING A ROW on LOCALIZATION: ${err}`);
  }
};

export const fetchLocalization = async (req, res, next) => {
  logger.info("GET /api/admin/localization");
  try {
    const result = await fetchLocalizationsService({});
    res.json(result);
  } catch (err) {
    next(`ERROR ON FETCHING FROM LOCALIZATION: ${err}`);
  }
};

export const updateLocalization = async (req, res, next) => {
  logger.info("PUT /api/admin/localization");
  logger.warn(`CRL --- ${JSON.stringify(req.body)}`);

  try {
    const { id, key, languagecode, textcontent, component } = req.body;
    // Validate required fields
    if (!id || !key || !languagecode || !textcontent || !component) {
      const missingFields = [];
      if (!id) missingFields.push('id');
      if (!key) missingFields.push('key');
      if (!languagecode) missingFields.push('languagecode');
      if (!textcontent) missingFields.push('textcontent');
      if (!component) missingFields.push('component');
      return res.status(400).json({ error: `Missing required fields: ${missingFields.join(', ')}` });
    }

    const result = await updateLocalizationService(id, key, languagecode, textcontent, component);

    // Implementation will be in service layer
    res.json({ message: `Localization ${id} updated successfully` });
  } catch (err) {
    next(`ERROR ON UPDATING ROW IN LOCALIZATION: ${err}`);
  }
};

export const deleteLocalization = async (req, res, next) => {
  logger.info("DELETE /api/admin/localization");
  try {
    const { id } = req.body;

    // Validate required fields
    if (!id) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await deleteLocalizationService(id);

    // Implementation will be in service layer
    res.json({ message: `Localization ${id} deleted successfully` });
  } catch (err) {
    next(`ERROR ON DELETING ROW FROM LOCALIZATION: ${err}`);
  }
};

export const createEstablishment = async (req, res, next) => {
  logger.info("POST /api/admin/establishment");
  // logger.warn(`REQUEST BODY: ${JSON.stringify(req.body)}`);
  try {
    const {
      est_name, type, city_mun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi
    } = req.body;

    // Validate required fields
    const missingFields = [];
    if (!est_name) missingFields.push('est_name');
    if (!type) missingFields.push('type');
    if (!city_mun) missingFields.push('city_mun');
    if (!barangay) missingFields.push('barangay');
    if (!latitude) missingFields.push('latitude');
    if (!longitude) missingFields.push('longitude');

    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing required fields: ${missingFields.join(', ')}` });
    }

    const result = await createEstablishmentService(
      est_name, type, city_mun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi
    );

    res.status(201).json(result);
  } catch (err) {
    next(`ERROR ON CREATING A ROW IN ESTABLISHMENTS: ${err}`);
  }
};

export const fetchEstablishments = async (req, res, next) => {
  logger.info("GET /api/admin/establishments");
  try {
    const filters = {
      est_name: req.query.est_name,
      type: req.query.type,
      city_mun: req.query.city_mun,
      barangay: req.query.barangay
    };

    const establishments = await fetchEstablishmentsService(filters);
    res.json(establishments);
  } catch (err) {
    next(`ERROR ON FETCHING FROM ESTABLISHMENTS: ${err}`);
  }
};
export const updateEstablishment = async (req, res, next) => {
  logger.info("PUT /api/admin/establishments");
  // logger.warn(`REQ BODY : ${JSON.stringify(req.body)}`);
  try {
    const {
      id, est_name, type, city_mun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi
    } = req.body;

    // Validate required fields
    if (!id || !est_name || !type || !city_mun || !barangay || !latitude || !longitude) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await updateEstablishmentService(
      id, est_name, type, city_mun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi
    );

    res.json({ message: `Establishment ${id} updated successfully`, establishment: result });
  } catch (err) {
    next(`ERROR ON UPDATING ROW IN ESTABLISHMENTS: ${err}`);
  }
}

export const deleteEstablishment = async (req, res, next) => {
  logger.info("DELETE /api/admin/establishments");
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).json({ error: 'Missing required id' });
    }

    const result = await deleteEstablishmentService(id);
    res.json({ message: `Establishment ${id} deleted successfully`, establishment: result });
  } catch (err) {
    next(`ERROR ON DELETING ROW FROM ESTABLISHMENTS: ${err}`);
  }
};
export const createTourismAttractionController = async (req, res, next) => {
  logger.info("POST /api/admin/tourismattractions");
  // logger.warn(`CREATE TOUATT REQ BODY-> ${JSON.stringify(req.body)}`);
  try {
    const {
      ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
      latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
    } = req.body;

    const missingFields = [];
    if (!ta_name) missingFields.push('ta_name');
    if (!type_code) missingFields.push('type_code');
    if (!region) missingFields.push('region');
    if (!prov_huc) missingFields.push('prov_huc');
    if (!city_mun) missingFields.push('city_mun');
    if (!report_year) missingFields.push('report_year');

    if (missingFields.length > 0) {
      return res.status(400).json({ error: `Missing required fields: ${missingFields.join(', ')}` });
    }

    const result = await createTourismAttractionService(
      ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
      latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
    );

    res.status(201).json(result);
  } catch (err) {
    next(`ERROR ON CREATING TOURISM ATTRACTION: ${err}`);
  }
};
export const fetchTourismAttractionController = async (req, res, next) => {
  logger.info("GET /api/admin/tourismattractions");
  try {
    const filters = {
      ta_name: req.query.ta_name,
      type_code: req.query.type_code,
      region: req.query.region,
      city_mun: req.query.city_mun,
      report_year: req.query.report_year,
      ta_category: req.query.ta_category
    };

    const attractions = await fetchTourismAttractionsService(filters);
    res.json(attractions);
  } catch (err) {
    next(`ERROR ON FETCHING TOURISM ATTRACTIONS: ${err}`);
  }
};
export const updateTourismAttractionController = async (req, res, next) => {
  logger.info("PUT /api/admin/tourismattractions");
  try {
    const {
      id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
      latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
    } = req.body;

    if (!id || !ta_name || !type_code || !region || !prov_huc || !city_mun || !report_year) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await updateTourismAttractionService(
      id, ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
      latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
    );

    res.json({ message: `Tourism attraction ${id} updated successfully`, attraction: result });
  } catch (err) {
    next(`ERROR ON UPDATING TOURISM ATTRACTION: ${err}`);
  }
};

export const deleteTourismAttractionController = async (req, res, next) => {
  logger.info("DELETE /api/admin/tourismattractions");
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).json({ error: 'Missing required id' });
    }

    const result = await deleteTourismAttractionService(id);
    res.json({ message: `Tourism attraction ${id} deleted successfully`, attraction: result });
  } catch (err) {
    next(`ERROR ON DELETING TOURISM ATTRACTION: ${err}`);
  }
};

//this is kinda impossible/impractical to do since survey_responses has a tightly integrated fkeys and structure matters
export const createSurveyResponseController = async (req, res, next) => {
  logger.info("POST /api/admin/survey-response");
  try {
    const { anonymous_user_id, surveyquestion_ref, response_value } = req.body;

    if (!anonymous_user_id || !surveyquestion_ref || !response_value) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await createSurveyResponse(anonymous_user_id, surveyquestion_ref, response_value);
    res.status(201).json(result);
  } catch (err) {
    next(`ERROR ON CREATING SURVEY RESPONSE: ${err}`);
  }
};

export const fetchSurveyResponsesController = async (req, res, next) => {
  logger.info("GET /api/admin/survey-responses");
  try {
    const anonid = req.query.anonid || null;
    logger.warn(`PROVIDED ANONID: ${anonid}`);
    const responses = await fetchSurveyResponsesService(anonid);
    res.json(responses);
  } catch (err) {
    next(`ERROR ON FETCHING SURVEY RESPONSES: ${err}`);
  }
};

export const updateSurveyResponseController = async (req, res, next) => {
  logger.info("PUT /api/admin/survey-responses");
  try {
    const { response_id, response_value } = req.body;

    if (!response_id || !response_value) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await updateSurveyResponseService(response_id, response_value);
    res.json({ message: `Survey response ${response_id} updated successfully`, response: result });
  } catch (err) {
    next(`ERROR ON UPDATING SURVEY RESPONSE: ${err}`);
  }
};

export const deleteSurveyResponseController = async (req, res, next) => {
  logger.info("DELETE /api/admin/survey-responses");
  try {
    const { anonymous_user_id } = req.body;

    if (!anonymous_user_id) {
      return res.status(400).json({ error: 'Missing required anonid' });
    }

    const result = await deleteSurveyResponseService(anonymous_user_id);
    res.json({ message: `Survey response ${anonymous_user_id} deleted successfully`, response: result });
  } catch (err) {
    next(`ERROR ON DELETING SURVEY RESPONSE: ${err}`);
  }
};

export const fetchSurveyQuestionsController = async (req, res, next) => {
  logger.database("GET /api/admin/survey-questions");
  try {
    const questions = await fetchSurveyQuestionsService();
    res.json(questions);
  } catch (err) {
    next(`ERROR ON FETCHING SURVEY QUESTIONS: ${err}`);
  }
};

export const createSentimentAnalysisController = async (req, res, next) => {
  logger.database("POST /api/admin/sentiment_analysis");

  // Extract the 'results' array from the request body
  const { results } = req.body;
  logger.warn(`SENTIMENT RESULTS BODY --> ${JSON.stringify(results)}`);

  try {
    // Validate that 'results' is a non-empty array
    if (!Array.isArray(results) || results.length === 0) {
      return res.status(400).json({
        error: 'Results should be a non-empty array of objects',
      });
    }

    // Validate that each object in the array contains all the required fields
    for (const result of results) {
      const { user_id, review_date, rating, sqref, sentiment, confidence } = result;
      if (!user_id || !review_date || !rating || !sqref || !sentiment || !confidence) {
        return res.status(400).json({
          error: `Missing required fields in one of the result objects: ${JSON.stringify(result)}`,
        });
      }
    }

    // Create the sentiment analysis entries in one bulk operation
    const createdResults = await createSentimentAnalysisService(results);

    // Respond with the newly created records
    res.status(201).json(createdResults);
  } catch (err) {
    // Pass any errors to the error-handling middleware
    next(`ERROR ON CREATING SENTIMENT ANALYSIS: ${err}`);
  }
};

export const fetchSentimentAnalysisController = async (req, res, next) => {
  logger.database("GET /api/admin/sentiment_analysis");
  try {
    const filters = {
      user_id: req.query.user_id,
      sqref: req.query.sqref,
      sentiment: req.query.sentiment
    };

    const result = await fetchSentimentAnalysisService(filters);
    res.json(result);
  } catch (err) {
    next(`ERROR ON FETCHING SENTIMENT ANALYSIS: ${err}`);
  }
};

export const updateSentimentAnalysisController = async (req, res, next) => {
  logger.database("PUT /api/admin/sentiment_analysis");
  try {
    const { id, user_id, review_date, rating, sqref, sentiment, confidence } = req.body;

    if (!id || !user_id || !review_date || !rating || !sqref || !sentiment || !confidence) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await updateSentimentAnalysisService(id, user_id, review_date, rating, sqref, sentiment, confidence);
    res.json({ message: `Sentiment analysis ${id} updated successfully`, analysis: result });
  } catch (err) {
    next(`ERROR ON UPDATING SENTIMENT ANALYSIS: ${err}`);
  }
};

export const deleteSentimentAnalysisController = async (req, res, next) => {
  logger.database("DELETE /api/admin/sentiment_analysis");
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).json({ error: 'Missing required id' });
    }

    const result = await deleteSentimentAnalysisService(id);
    res.json({ message: `Sentiment analysis ${id} deleted successfully`, analysis: result });
  } catch (err) {
    next(`ERROR ON DELETING SENTIMENT ANALYSIS: ${err}`);
  }
};
export const insertTopicDataController = async (req, res, next) => {
  logger.info("POST /api/admin/insertTopicData");
  logger.warn(`REQ BODY --> ${JSON.stringify(req.body.zeroidx)}`)

  try {
    const data = req.body.zeroidx;

    // Validate required fields
    for (const item of [data]) {
      const { topic, probability, top_words, customLabel, contribution } = item;
      const missingFields = [];
      if (!topic) missingFields.push('topic');
      if (!probability) missingFields.push('probability');
      if (!top_words || !Array.isArray(top_words) || top_words.length === 0) missingFields.push('top_words');
      if (!customLabel) missingFields.push('customLabel');
      if (!contribution || !Array.isArray(contribution) || contribution.length === 0) missingFields.push('contribution');

      if (missingFields.length > 0) {
        return res.status(400).json({ error: `Missing required fields: ${missingFields.join(', ')}` });
      }
    }

    const result = await insertTopicDataService(data);
    res.status(201).json(result);
  } catch (err) {
    res.status(400).json({ error: `ERROR ON INSERTING TOPIC DATA: ${err.message}` });
  }
};

export const fetchAllTouchpointsController = async (req, res, next) => {
  logger.info("GET /api/admin/touchpoints");
  try {
    const result = await fetchAllTouchpointsService();
    res.json(result);
  } catch (err) {
    next(`ERROR ON FETCHING ALL TOUCHPOINTS: ${err}`);
  }
};

export const fetchTranslatedTouchpointController = async (req, res, next) => {
  logger.info("GET /api/admin/tourismattractions/translate");
  logger.warn(`BODY OF REQ --> ${JSON.stringify(req.body)}`);
  try {
    const { entityname, languagecode } = req.body;

    if (!entityname || !languagecode) {
      return res.status(400).json({ error: 'Missing required query parameters' });
    }

    const translatedName = await fetchTranslatedTouchpointService(entityname, languagecode);
    logger.warn(`TRANSLATED NAAMMMEEEE --- ${translatedName}`);
    res.json({ translatedName });
  } catch (err) {
    next(`ERROR ON FETCHING TRANSLATED TOUCHPOINT: ${err}`);
  }
};


export const groupByLikertRatingController = async (req, res) => {
  try {
    const surveyResponses = await groupByLikertRatingService(); 

    const formattedResponse = surveyResponses.map((row) => ({
      question: row.content,
      topic: row.surveytopic,
      questionRef: row.surveyquestion_ref,
      responses: {
        Dissatisfied: row.dissatisfied,
        Neutral: row.neutral,
        Satisfied: row.satisfied,
        VerySatisfied: row.verysatisfied,
      },
    }));

    // Send the formatted response
    res.json({
      data: formattedResponse,
    });
  } catch (error) {
    console.error('Error in controller:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
    });
  }
};


export const getSurveyMetricsAnalyticsController = async (req, res, next) => {
  logger.info("GET ALL METRICS");
  const restructureData = (data) => {
    return data.reduce((acc, item) => {
      const { touchpoint, total_unique_user_count } = item;
      acc[touchpoint] = total_unique_user_count;
      return acc;
    }, {});
  };
  try {
    // Fetch data from your functions
    const finishedRows = await fetchAllFinishedRows(); 
    const totalSurveysCompleted = parseInt(finishedRows.finished); 

    const unfinishedSurveys = await fetchUnfinishedSurveys();
    const totalSurveysUnCompleted = parseInt(unfinishedSurveys.count);

    const totalMixedSurveys = totalSurveysCompleted + totalSurveysUnCompleted;
    const completionRate = (totalSurveysCompleted/totalMixedSurveys).toFixed(4)*100;
    const dropOffRate = parseFloat(((totalSurveysUnCompleted/totalMixedSurveys)*100).toFixed(2));
    const aveCompletionTime = await calculateAverageCompletionTimeService();

    const getTouchpoints = await fetchTouchpointsService();
    
    const surveyResponsesByMonth = await fetchAndGroupFinishedSurveyResponsesByMonthService();
    const getTimeofDay = await fetchByTimeOfDay();
    const surveyResponsesByRegion = await fetchByNationality();
    const ageGroup = await fetchByAgeGroup();
    const genderGroup = await fetchByGender();
    const surveyResponsesByCountry = await fetchByCountryResidence();


    // Add more function calls here as needed
    // const anotherData = await anotherFunction();

    // Construct the response structure
    const responseData = {
        totalSurveysCompleted: totalSurveysCompleted, // Insert fetched data
        totalSurveys: totalMixedSurveys,
        surveyCompletionRate: completionRate,
        averageTimeToComplete: aveCompletionTime,
        dropOffRate: dropOffRate, 
        surveyDistribution:getTouchpoints,
        surveyResponsesByRegion,
        surveyResponsesByAgeGroup: ageGroup,
        surveyResponsesByGender: genderGroup,
        surveyResponsesByTimeOfDay:getTimeofDay,
        surveyResponsesByMonth,
        surveyResponsesByCountry, 
    };

    // Respond with the constructed data
    res.status(200).json({
        success: true,
        message: "Survey data retrieved successfully",
        data: responseData,
    });
} catch (error) {
    // Handle errors
    next(error);
}
}

export const getSurveyFeedbackController = async (req, res) => {
  try {
      const result = await fetchEntityinSurveyFeedbackService();
      
      if (result.length === 0) {
          return res.status(204).json({ message: 'No content found' });
      }

      res.status(200).json(result);
  } catch (error) {
      console.error('Error in controller:', error);
      res.status(500).json({ message: 'Internal server error' });
  }
};
export const getAllByTallyController = async (req, res) => {
  try {
      // Call the service function to get the survey responses
      const surveyResponses = await getAllSurveyTally();

      // Send the response back to the client
      res.status(200).json(surveyResponses);
  } catch (error) {
      console.error('Error in surveyResponsesController:', error);
      res.status(500).json({ error: 'Internal Server Error' });
  }
};
export const getSentimentAnalysisController = async (req, res) => {
  try {
    // Call the service function to get sentiment analysis data
    const sentimentAnalysisData = await getSentimentAnalysis();

    // Send the response as JSON
    res.status(200).json(sentimentAnalysisData);
  } catch (error) {
    // Handle errors and send an appropriate response
    res.status(500).json({ error: error.message });
  }
};