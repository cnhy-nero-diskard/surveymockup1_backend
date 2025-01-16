// controllers/surveyController.js
import logger from '../middleware/logger.js';
import { submitSurveyResponse, fetchSurveyResponsesByUser } from '../services/surveyService.js';

/**
 * Submit a survey response.
 */
export const submitSurveyResponseController = async (req, res) => {
    logger.info("POST /api/survey/submit");
    try {
        const response = req.body;
        const result = await submitSurveyResponse(response);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
};

/**
 * Fetch all survey responses for a specific user.
 */
export const fetchSurveyResponsesController = async (req, res) => {
    logger.info("GET /api/survey/responses/:user_id");
    try {
        const { user_id } = req.params;
        const responses = await fetchSurveyResponsesByUser(user_id);
        res.json(responses);
    } catch (err) {
        next(err);
    }
};