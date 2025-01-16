// services/surveyService.js
import pool from '../config/db.js';

/**
 * Submit a survey response to the database.
 * @param {Object} response - The survey response object.
 * @returns {Promise<Object>} - The inserted survey response.
 */
export const submitSurveyResponse = async (response) => {
    const query = `
        INSERT INTO survey_responses (
            user_id, 
            component_name, 
            question_key, 
            response_value, 
            language_code, 
            is_open_ended, 
            category
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING *;
    `;

    const values = [
        response.user_id,
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

/**
 * Fetch all survey responses for a specific user.
 * @param {number} user_id - The ID of the user.
 * @returns {Promise<Array>} - List of survey responses for the user.
 */
export const fetchSurveyResponsesByUser = async (user_id) => {
    const query = `
        SELECT * FROM survey_responses
        WHERE user_id = $1;
    `;
    const result = await pool.query(query, [user_id]);
    return result.rows;
};