// services/surveyService.js
import pool from '../config/db.js';
import logger from '../middleware/logger.js';

/**
 * Submit a survey response to the database.
 * @param {Object} response - The survey response object.
 * @returns {Promise<Object>} - The inserted survey response.
 */
export const submitSurveyResponse = async (response, anonymousUserId) => {
    const query = `
        INSERT INTO survey_responses (
            user_id, 
            anonymous_user_id, 
            component_name, 
            question_key, 
            response_value, 
            language_code, 
            is_open_ended, 
            category
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *;
    `;

    const values = [
        response.user_id,
        anonymousUserId, // Store the anonymous user ID as a foreign key
        response.component_name,
        response.question_key,
        response.response_value,
        response.language_code,
        response.is_open_ended,
        response.category,
    ];

    const result = await pool.query(query, values);
    return result.rows[0];
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