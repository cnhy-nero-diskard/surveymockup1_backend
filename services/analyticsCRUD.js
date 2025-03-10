import pool from "../config/db.js";
import logger from "../middleware/logger.js";
//EACH ONE OF THESE ARE HELPER FUNCTIONS. A CONTROLLER MAY CHOOSE TO AGGREGATE THEM


// Function tally languages according to 'LANGPERF' returns 
export const countLangPerfSurveyResponsesService = async () => {
    logger.database("METHOD api/admin/countLangPerfSurveyResponses");
    try {
        const query = `

      WITH langperf_responses AS (
        SELECT 
            response_value,
            COUNT(*) AS occurrence_count
        FROM 
            survey_responses
        WHERE 
            surveyquestion_ref = 'LANGPERF'
        GROUP BY 
            response_value
    )
    SELECT 
        response_value,
        occurrence_count
    FROM 
        langperf_responses
    ORDER BY 
        response_value;
          `;
        const result = await pool.query(query);
        // Return the count of rows
        return result.rows[0];
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
    const restructureData = (data) => {
        return data.reduce((acc, item) => {
          const { month_bucket, response_count } = item;
          acc[month_bucket] = response_count;
          return acc;
        }, {});
    }  ;  
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
        const clresult = restructureData(result.rows);
        // Return the grouped result
        return clresult;
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

        // Get the average completion time in minutes
        const average = result.rows[0].average_completion_time;

        if (average === null) {
            return "No data available";
        }

        // Convert minutes to a formatted time string
        const minutes = Math.floor(average);
        const seconds = Math.round((average - minutes) * 60);

        // If seconds equal 60, increment minutes and set seconds to 0
        let formattedTime;
        if (seconds === 60) {
            formattedTime = `${minutes + 1} mins 0 secs`;
        } else {
            formattedTime = `${minutes} mins ${seconds} secs`;
        }

        return formattedTime;
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
export const groupByLikertRatingService = async () => {
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
        return result.rows;
    } catch (error) {
        console.error('Error executing query:', error);
        throw error;
    }
};

//FETCH ALL THE COMPLETED 'FINISH' SIGNAL ROWS IN SURVEY_RESPONSES

// returns {
//     "finished": "8"
//   }
export const fetchAllFinishedRows = async () => {
    logger.database("METHOD COUNT FINISHED USERS");

    try {
        const query = `
      SELECT COUNT(*) as Finished
      FROM survey_responses 
      WHERE surveyquestion_ref = 'FINISH';`
        const result = await pool.query(query);
        return result.rows[0];


    } catch (err) {
        logger.error({ error: err.message });
        throw err;

    }
}

export const fetchUnfinishedSurveys = async () => {
    logger.database("METHOD COUNT UNFINISHED USERS ");
    try {
        const query = `
        SELECT COUNT(DISTINCT anonymous_user_id)
        FROM survey_responses
        WHERE anonymous_user_id IN (
        SELECT anonymous_user_id
        FROM survey_responses
        WHERE surveyquestion_ref IN ('LANGPERF', 'FINISH')
        GROUP BY anonymous_user_id
        HAVING COUNT(DISTINCT surveyquestion_ref) < 2
        );`
        const result = await pool.query(query);
        return result.rows[0];
    } catch (error) {
        logger.error({ error: err.message });
        throw err;

    }
}

export const fetchTouchpointsService = async () => {
    const restructureData = (data) => {
        return data.reduce((acc, item) => {
          const { touchpoint, total_unique_user_count } = item;
          acc[touchpoint] = total_unique_user_count;
          return acc;
        }, {});
      };
      
    logger.database("METHOD COUNT TOUCHPOINTS");
    try {
        const query = `SELECT
    COALESCE(sr.touchpoint, sf.touchpoint) AS touchpoint,
    COALESCE(sr.unique_user_count, 0) + COALESCE(sf.unique_user_count, 0) AS total_unique_user_count
FROM
    (SELECT touchpoint, COUNT(DISTINCT anonymous_user_id) AS unique_user_count FROM public.survey_responses GROUP BY touchpoint) AS sr
FULL OUTER JOIN
    (SELECT touchpoint, COUNT(DISTINCT anonymous_user_id) AS unique_user_count FROM public.survey_feedback GROUP BY touchpoint) AS sf ON sr.touchpoint = sf.touchpoint;`
        const result = await pool.query(query);
        const clresult = restructureData(result.rows)

        return clresult;
    } catch (error) {
        logger.error({ error: err.message });
        throw err;

    }
}

export const fetchByTimeOfDay = async () => {
    const restructureData = (data) => {
        return data.reduce((acc, item) => {
          const { time_period, distinct_user_count } = item;
          acc[time_period] = distinct_user_count;
          return acc;
        }, {});
      };

    logger.database("METHOD COUNTING TIME OF DAY FOR SURVEYS");
    try{    
        const query = `SELECT 
        CASE 
            WHEN EXTRACT(HOUR FROM created_at) < 6 THEN 'Dusk'
            WHEN EXTRACT(HOUR FROM created_at) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM created_at) < 18 THEN 'Afternoon'
            ELSE 'Night'
        END AS time_period,
        COUNT(DISTINCT anonymous_user_id) AS distinct_user_count
        FROM public.survey_responses
        GROUP BY 1
        ORDER BY 1;`;
    const result = await pool.query(query);
    return restructureData(result.rows);
    }catch(error){
        logger.error({ error: err.message });
        throw err;
    }
}

export const fetchByNationality = async () => {
    logger.database('METHOD FETCHING TALLY BY NATIONALITY');
    const restructureData = (data) => {
        return data.reduce((acc, item) => {
          const { response_value, count_response_value } = item;
          acc[response_value] = count_response_value;
          return acc;
        }, {});
      };

    try {
        const query = `

                -- Tally similar response_value for surveyquestion_ref = 'NAT01'
                SELECT response_value, COUNT(*) AS count_response_value
                FROM public.survey_responses
                WHERE surveyquestion_ref = 'NAT01'
                GROUP BY response_value
                ORDER BY count_response_value DESC;`
        const result = await pool.query(query);
        return restructureData(result.rows);
        
    } catch (error) {
        logger.error({ error: err.message });
        throw err;

    }
}