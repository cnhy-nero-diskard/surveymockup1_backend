// controllers/surveyController.js
import logger from '../middleware/logger.js';
import { submitSurveyResponse, fetchSurveyResponsesByUser } from '../services/surveyService.js';
/**
 * Submit a survey response.
 */
// controllers/surveyController.js
export const submitSurveyResponseController = async (req, res, next) => {
    logger.info("POST /api/survey/submit");
    try {
        const response = req.body;
        const anonymousUserId = req.session.anonymousUserId;
        const result = await submitSurveyResponse(response, anonymousUserId);
        res.status(201).send("OK");
    } catch (err) {
        logger.info("SOMETHING HAPPENED")
        next(err);
    }
};

export const fetchSurveyResponsesController = async (req, res) => {
    logger.info("GET /api/survey/responses/:user_id");
    try {
        const { user_id } = req.params;
        const anonymousUserId = req.cookies.anonymousUserId;
        const responses = await fetchSurveyResponsesByUser(user_id, anonymousUserId);
        res.send(201).json(responses);
    } catch (err) {
        next(err);
    }
};