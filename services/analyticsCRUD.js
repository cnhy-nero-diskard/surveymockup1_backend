import pool from "../config/db.js";
import logger from "../middleware/logger.js";

// Function to count rows with surveyquestion_ref value of 'FINISH'
export const countFinishedSurveyResponsesService = async () => {
    logger.database("METHOD api/admin/countFinishedSurveyResponses");
    try {
      const query = `
        SELECT COUNT(*) FROM public.survey_responses
        WHERE surveyquestion_ref = 'FINISH';
      `;
      const result = await pool.query(query);
      // Return the count of rows
      return result.rows[0].count;
    } catch (err) {
      logger.error({ error: err.message });
      throw err;
    }
  };
  // Function to count rows with surveyquestion_ref value of 'LANGPERF'
  export const countLangPerfSurveyResponsesService = async () => {
    logger.database("METHOD api/admin/countLangPerfSurveyResponses");
    try {
      const query = `
        SELECT COUNT(*) FROM public.survey_responses
        WHERE surveyquestion_ref = 'LANGPERF';
      `;
      const result = await pool.query(query);
      // Return the count of rows
      return result.rows[0].count;
    } catch (err) {
      logger.error({ error: err.message });
      throw err;
    }
  };
// Function to fetch all rows with surveyquestion_ref value of 'LANGPERF'
export const fetchLangPerfSurveyResponsesService = async () => {
    logger.database("METHOD api/admin/fetchLangPerfSurveyResponses");
    try {
        const query = `
            SELECT * FROM public.survey_responses
            WHERE surveyquestion_ref = 'LANGPERF';
        `;
        const result = await pool.query(query);
        // Return all rows
        return result.rows;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};
// // Function to tally rows according to their touchpoint column
// export const tallyTouchpointSurveyResponsesService = async () => {
//     logger.database("METHOD api/admin/tallyTouchpointSurveyResponses");
//     try {
//         const query = `
//             SELECT touchpoint, COUNT(*) as count
//             FROM public.survey_responses
//             GROUP BY touchpoint;
//         `;
//         const result = await pool.query(query);
//         // Transform the result into the desired structure
//         const tally = result.rows.reduce((acc, row) => {
//             acc[row.touchpoint] = parseInt(row.count, 10);
//             return acc;
//         }, {});
//         return tally;
//     } catch (err) {
//         logger.error({ error: err.message });
//         throw err;
//     }
// };
// Function to fetch all rows with surveyquestion_ref value of 'AGE01'
export const fetchAgeSurveyResponsesService = async () => {
    logger.database("METHOD api/admin/fetchAgeSurveyResponses");
    try {
        const query = `
            SELECT response_value FROM public.survey_responses
            WHERE surveyquestion_ref = 'AGE01';
        `;
        const result = await pool.query(query);
        // Return all ages as an array
        return result.rows.map(row => row.response_value);
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};
// Function to fetch and group rows with surveyquestion_ref value of 'FINISH' by month
export const fetchAndGroupFinishedSurveyResponsesByMonthService = async () => {
    logger.database("METHOD api/admin/fetchAndGroupFinishedSurveyResponsesByMonth");
    try {
        const query = `
            SELECT TO_CHAR(created_at, 'Month YYYY') AS month_bucket, 
                   COUNT(response_id) AS response_count
            FROM public.survey_responses
            WHERE surveyquestion_ref = 'FINISH'
            GROUP BY month_bucket
            ORDER BY MIN(created_at);
        `;
        const result = await pool.query(query);
        // Return the grouped result
        return result.rows;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};


// Function to calculate the average time to complete the survey (in minutes)
export const calculateAverageCompletionTimeService = async () => {
    logger.database("METHOD api/admin/calculateAverageCompletionTime");
    try {
        const query = `
            WITH langperf_times AS (
                SELECT anonymous_user_id, created_at AS langperf_time
                FROM public.survey_responses
                WHERE surveyquestion_ref = 'LANGPERF'
            ),
            finish_times AS (
                SELECT anonymous_user_id, created_at AS finish_time
                FROM public.survey_responses
                WHERE surveyquestion_ref = 'FINISH'
            ),
            completion_times AS (
                SELECT l.anonymous_user_id, 
                       EXTRACT(EPOCH FROM (f.finish_time - l.langperf_time)) / 60 AS completion_time_minutes
                FROM langperf_times l
                JOIN finish_times f ON l.anonymous_user_id = f.anonymous_user_id
                WHERE f.finish_time IS NOT NULL
            )
            SELECT AVG(completion_time_minutes) AS average_completion_time
            FROM completion_times;
        `;
        const result = await pool.query(query);
        // Return the average completion time in minutes
        return result.rows[0].average_completion_time;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};

// Function to group and count rows by sentiment
export const countSentimentAnalysisService = async () => {
    logger.database("METHOD api/admin/countSentimentAnalysis");
    try {
        const query = `
            SELECT sentiment, COUNT(*) as count
            FROM public.sentiment_analysis
            GROUP BY sentiment;
        `;
        const result = await pool.query(query);
        // Transform the result into the desired structure
        const sentimentCounts = result.rows.reduce((acc, row) => {
            acc[row.sentiment] = parseInt(row.count, 10);
            return acc;
        }, {});
        return sentimentCounts;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};

// Function to group survey responses by question title
export const groupResponsesByQuestionTitleService = async () => {
    logger.database("METHOD api/admin/groupResponsesByQuestionTitle");
    try {
        const query = `
            SELECT 
            sq.title,
            sq.content,
            array_agg(sr.response_value) as responses
            FROM 
            public.survey_responses sr
            INNER JOIN public.survey_questions sq 
            ON sr.surveyquestion_ref = sq.surveyresponses_ref
            GROUP BY 
            sq.title,
            sq.content
            ORDER BY 
            sq.title;
        `;
        const result = await pool.query(query);
        // logger.warn(`RESULT --> ${JSON.stringify(result)}`);
        return result.rows;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};

// Function to count establishments by type
export const countEstablishmentsByTypeService = async () => {
    logger.database("METHOD api/admin/countEstablishmentsByType");
    try {
        const query = `
            SELECT type, COUNT(*) as count
            FROM public.establishments
            GROUP BY type
            ORDER BY type;
        `;
        const result = await pool.query(query);
        const typeCounts = result.rows.reduce((acc, row) => {
            acc[row.type] = parseInt(row.count, 10);
            return acc;
        }, {});
        return typeCounts;
    } catch (err) {
        logger.error({ error: err.message });
        throw err;
    }
};

// Function to group all rows in surveyresponses according to surveyquestion_ref
// IF the fkey corresponds to a row of questiontype "RATINGSCALE" within survey_questions
export const groupByLikertRating = async () => {
    const query = `
      SELECT
        sq.content,
        sq.surveytopic,
        sr.surveyquestion_ref,
        COUNT(CASE WHEN sr.response_value = '1' THEN 1 END) AS Dissatisfied,
        COUNT(CASE WHEN sr.response_value = '2' THEN 1 END) AS Neutral,
        COUNT(CASE WHEN sr.response_value = '3' THEN 1 END) AS Satisfied,
        COUNT(CASE WHEN sr.response_value = '4' THEN 1 END) AS VerySatisfied
      FROM public.survey_responses sr
      JOIN public.survey_questions sq ON sr.surveyquestion_ref = sq.surveyresponses_ref
      WHERE sq.questiontype = 'RATINGSCALE'
      GROUP BY sr.surveyquestion_ref, sq.content, sq.surveytopic;
    `;
  
    try {
      const result = await pool.query(query);
      return result.rows; // Return the query results
    } catch (error) {
      console.error('Error executing query:', error);
      throw error; // Throw the error to be handled by the controller
    }
  };