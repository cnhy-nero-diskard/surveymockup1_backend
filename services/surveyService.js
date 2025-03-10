// services/surveyService.js
import pool from '../config/db.js';
import logger from '../middleware/logger.js';

/**
 * Submits a survey response to the database.
 *
 * @param {Object} response - The survey response object.
 * @param {string} response.surveyquestion_ref - The reference ID of the survey question. Must be a string of less than 10 characters.
 * @param {Object} response.response_value - The value of the response. Must be a JSONB-compatible object.
 * @param {string} anonymousUserId - The ID of the anonymous user submitting the response.
 * @returns {Promise<Object>} The inserted survey response record.
 *
 * @throws {Error} If there is an issue with the database query.
 */
export const submitSurveyResponse = async (response, anonymousUserId) => {
    const logtext = `[POST][SURVEY_RESPONSES] -- UserID ${anonymousUserId} has SUBMITTED ${response.surveyquestion_ref}`;
    logger.database(logtext);

    const query = `
        INSERT INTO survey_responses (
            anonymous_user_id, 
            surveyquestion_ref, 
            response_value,
            touchpoint
        )
        VALUES ($1, $2, $3, $4)
        ON CONFLICT (anonymous_user_id, surveyquestion_ref)
        DO UPDATE SET 
            response_value = EXCLUDED.response_value
        RETURNING *;
    `;

    const values = [
        anonymousUserId, 
        response.surveyquestion_ref,
        response.response_value,  
        response.touchpoint  
    ];

    try {
        const result = await pool.query(query, values);
        return result.rows[0];
    } catch (err) {
        logger.error(`Error submitting survey response: ${err.message}`);
        throw err;
    }
};

export const fetchSurveyResponsesByUser = async (user_id, anonymousUserId) => {
    const query = `
        SELECT 
            sr.*, 
            au.created_at AS anonymous_user_created_at
        FROM survey_responses sr
        LEFT JOIN anonymous_users au ON sr.anonymous_user_id = au.anonymous_user_id
        WHERE sr.user_id = $1 OR sr.anonymous_user_id = $2;
    `;
    const result = await pool.query(query, [user_id, anonymousUserId]);
    return result.rows;
};