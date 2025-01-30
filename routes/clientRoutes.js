// routes/clientRoutes.js
import express from 'express';
import { getMunicipalities, getLanguageSelect, getTexts, getSurveyProgress, updateSurveyProgress } from '../controllers/clientController.js';
import { submitSurveyResponseController, fetchSurveyResponsesController } from '../controllers/surveyController.js';
import { handleAnonymousUser } from '../middleware/anonymousUserMiddleware.js';
import logger from '../middleware/logger.js';
import { validateSurveyStep } from '../middleware/authMiddleware.js';

const router = express.Router();

router.get('/', (req, res) => {
    res.send('Hello from the backend!');
});

router.get('/api/municipalities', getMunicipalities);
router.get('/api/languageselect', getLanguageSelect);
router.get('/api/texts', getTexts);
router.get('/api/survey/progress', getSurveyProgress);
router.post('/api/survey/progress', updateSurveyProgress);

router.post('/api/survey/submit', submitSurveyResponseController);
router.get('/api/survey/responses/:user_id', fetchSurveyResponsesController);
router.get('/api/init-anonymous-user', handleAnonymousUser, (req, res) => {
    logger.info('GET /api/init-anonymous-user');
    res.status(200).send('Anonymous user ID initialized');
});
router.get("/survey/step/:step", validateSurveyStep, (req, res) => {
    const step = req.params.step;
    res.send(`You are on step ${step}`);
  });

export default router;