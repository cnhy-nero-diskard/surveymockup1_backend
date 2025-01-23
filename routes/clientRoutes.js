// routes/clientRoutes.js
import express from 'express';
import { getMunicipalities, getLanguageSelect, getTexts } from '../controllers/clientController.js';
import { submitSurveyResponseController, fetchSurveyResponsesController } from '../controllers/surveyController.js';
import { generateAnonymousUserId } from '../middleware/anonymousUserMiddleware.js';
import logger from '../middleware/logger.js';

const router = express.Router();

router.get('/', (req, res) => {
    res.send('Hello from the backend!');
});

router.get('/api/municipalities', getMunicipalities);
router.get('/api/languageselect', getLanguageSelect);
router.get('/api/texts', getTexts);

router.post('/api/survey/submit', submitSurveyResponseController);
router.get('/api/survey/responses/:user_id', fetchSurveyResponsesController);
router.get('/api/init-anonymous-user', generateAnonymousUserId, (req, res) => {
    logger.info('GET /api/init-anonymous-user');
    res.status(200).send('Anonymous user ID initialized');
});


export default router;