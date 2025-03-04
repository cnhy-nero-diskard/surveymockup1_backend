// routes/adminRoutes.js
import express from 'express';
import { getAdminData, getAdminSessionData, updateTourismAttractionController, fetchTourismAttractionsController, addTourismAttractionController, deleteTourismAttractionController, posthftokens, gethftokens, analyzeSentiment, analyzeTopics, fetchAnonymousUsersController, logstream, getEstablishmentEnglishNamesController, getOpenEndedSurveyResponses, createLocalization, fetchLocalization, updateLocalization, deleteLocalization } from '../controllers/adminController.js';
import { authenticate, authorizeAdmin } from '../middleware/authMiddleware.js';
import { submitSurveyResponseController } from '../controllers/surveyController.js';
import { validateSurveyResponse } from '../middleware/validationMiddleware.js';
import { validateTourismAttraction } from '../middleware/validationMiddleware.js';
import { addTourismAttraction, getEstablishmentEnglishNames } from '../services/adminService.js';
import { getMetrics } from '../metrics/metricsController.js';

const router = express.Router();
router.get('/api/admin/data', authenticate, getAdminData);
router.get('/api/admin/fetch', authenticate, fetchTourismAttractionsController);
router.post('/api/admin/add', authenticate, addTourismAttractionController);
router.delete('/api/admin/delete/:id', authenticate, deleteTourismAttractionController);
router.put('/api/admin/update/:id', authenticate, updateTourismAttractionController);

router.post('/api/admin/add', validateTourismAttraction, addTourismAttractionController);
router.post('/api/survey/submit', validateSurveyResponse, submitSurveyResponseController);
router.get('/api/admin/session-data', authenticate, getAdminSessionData);
router.get('/metrics', getMetrics);
router.get('/api/admin/establishments', getEstablishmentEnglishNamesController);
router.get('/api/admin/survey-responses/open-ended', authenticate, getOpenEndedSurveyResponses);

router.post('/api/hf-tokens', posthftokens);
router.get('/api/hf-tokens', authenticate, gethftokens);
router.post('/api/analyzesentiment', analyzeSentiment);
router.post('/api/analyzetopics', analyzeTopics);

router.post('/api/admin/localization', createLocalization);
router.get('/api/admin/localization',  fetchLocalization);
router.put('/api/admin/localization', updateLocalization);
router.delete('/api/admin/localization', deleteLocalization);



router.get('/api/admin/anonymous-users', fetchAnonymousUsersController);
// router.get('api/log-stream', logstream)


export default router;