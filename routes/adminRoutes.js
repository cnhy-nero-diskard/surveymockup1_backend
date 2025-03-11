// routes/adminRoutes.js
import express from 'express';
import { getAdminData, getAdminSessionData, updateTourismAttractionController, addTourismAttractionController, deleteTourismAttractionController, posthftokens, gethftokens, analyzeSentiment, analyzeTopics, fetchAnonymousUsersController, logstream, getEstablishmentEnglishNamesController, getOpenEndedSurveyResponses, createLocalization, fetchLocalization, updateLocalization, deleteLocalization, createEstablishment, fetchEstablishments, updateEstablishment, deleteEstablishment, createTourismAttractionController, fetchTourismAttractionController, createSurveyResponseController, fetchSurveyResponsesController, updateSurveyResponseController, deleteSurveyResponseController, fetchSurveyQuestionsController, createSentimentAnalysisController, updateSentimentAnalysisController, fetchSentimentAnalysisController, deleteSentimentAnalysisController, insertTopicDataController, fetchAllTouchpointsController, fetchTranslatedTouchpointController, groupByLikertRatingController, getSurveyMetricsAnalyticsController } from '../controllers/adminController.js';
import { authenticate, authorizeAdmin } from '../middleware/authMiddleware.js';
import { submitSurveyResponseController } from '../controllers/surveyController.js';
import { validateSurveyResponse } from '../middleware/validationMiddleware.js';
import { validateTourismAttraction } from '../middleware/validationMiddleware.js';
import { getEstablishmentEnglishNames, purgeAnonymousUsers } from '../services/adminService.js';
import { getMetrics } from '../metrics/metricsController.js';
import { fetchAllTouchpointsService, fetchAllTourismAttractionsService, fetchLocationsService, fetchLocationsServiceFiltered, fetchTranslatedTouchpointService, insertTopicDataService } from '../services/adminCRUD.js';
import logger from "../middleware/logger.js";
import { calculateAverageCompletionTimeService, fetchByCountryResidence, fetchByGender, fetchAllFinishedRows, fetchAndGroupFinishedSurveyResponsesByMonthService, fetchByNationality, fetchByTimeOfDay, fetchTouchpointsService, fetchUnfinishedSurveys } from '../services/analyticsCRUD.js';

const router = express.Router();
router.get('/api/admin/data', authenticate, getAdminData);
// router.get('/api/admin/fetch', authenticate, fetchTourismAttractionsController);
// router.post('/api/admin/add', authenticate, addTourismAttractionController);
// router.delete('/api/admin/delete/:id', authenticate, deleteTourismAttractionController);
// router.put('/api/admin/update/:id', authenticate, updateTourismAttractionController);

router.post('/api/admin/add', validateTourismAttraction, addTourismAttractionController);
router.post('/api/survey/submit', validateSurveyResponse, submitSurveyResponseController);
router.get('/api/admin/session-data', authenticate, getAdminSessionData);
router.get('/metrics', getMetrics);
router.get('/api/admin/establishments', getEstablishmentEnglishNamesController);
router.get('/api/admin/survey-responses/open-ended', getOpenEndedSurveyResponses);

router.post('/api/hf-tokens', posthftokens);
router.get('/api/hf-tokens', authenticate, gethftokens);
router.post('/api/analyzesentiment', analyzeSentiment);
router.post('/api/analyzetopics', analyzeTopics);
router.post('/api/storetopics', insertTopicDataController);

router.post('/api/admin/localization', createLocalization);
router.get('/api/admin/localization',  fetchLocalization);
router.put('/api/admin/localization', updateLocalization);
router.delete('/api/admin/localization', deleteLocalization);

router.post('/api/admin/establishment', createEstablishment);
router.get('/api/admin/establishment',  fetchEstablishments);
router.put('/api/admin/establishment', updateEstablishment);
router.delete('/api/admin/establishment', deleteEstablishment);

router.post('/api/admin/touattraction', createTourismAttractionController);
router.get('/api/admin/touattraction',  fetchTourismAttractionController);
router.put('/api/admin/touattraction', updateTourismAttractionController);
router.delete('/api/admin/touattraction', deleteTourismAttractionController);

router.post ('/api/admin/survey-responses', createSurveyResponseController);
router.get ('/api/admin/survey-responses', fetchSurveyResponsesController);
router.put ('/api/admin/survey-responses', updateSurveyResponseController);
router.delete ('/api/admin/survey-responses', deleteSurveyResponseController);
router.delete ('/api/admin/deletesurveyuser', deleteSurveyResponseController);


router.post('/api/admin/sentiment_results', createSentimentAnalysisController);
router.get('/api/admin/sentiment_results', fetchSentimentAnalysisController);
router.put('/api/admin/sentiment_results', updateSentimentAnalysisController);
router.delete('/api/admin/sentiment_results', deleteSentimentAnalysisController);

router.get('/api/admin/survey-questions', fetchSurveyQuestionsController);

router.get('/api/admin/anonymous-users', fetchAnonymousUsersController);
router.delete('/api/admin/all-anonymous-users', purgeAnonymousUsers);

router.get('/api/surveytouchpoints', fetchAllTouchpointsController);
router.post('/api/touchpointlocal', fetchTranslatedTouchpointController);

router.get('/api/admin/getsurveymetrics', getSurveyMetricsAnalyticsController);

//TESTING ENDPOINT
router.get('/api/test', async (req, res) => {
    try {
        // Insert test function here
        const result = await fetchByCountryResidence() ;
        res.json(result);
    } catch (error) {
        console.error('Test endpoint error:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

export default router;

