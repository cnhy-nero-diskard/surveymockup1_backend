// routes/clientRoutes.js
import express from 'express';
import { getMunicipalities, getLanguageSelect, getTexts } from '../controllers/clientController.js';
import { submitSurveyResponseController, fetchSurveyResponsesController } from '../controllers/surveyController.js';

const router = express.Router();

router.get('/', (req, res) => {
    res.send('Hello from the backend!');
});

router.get('/api/municipalities', getMunicipalities);
router.get('/api/languageselect', getLanguageSelect);
router.get('/api/texts', getTexts);

// Survey response routes
router.post('/api/survey/submit', submitSurveyResponseController);
router.get('/api/survey/responses/:user_id', fetchSurveyResponsesController);

export default router;