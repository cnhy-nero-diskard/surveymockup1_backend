// services/adminService.js
import { Logger } from "winston";
import pool from "../config/db.js";
import logger from "../middleware/logger.js";

export const getAdminDataFromDB = async () => {
  const result = await pool.query('SELECT * FROM admin_table'); // Replace with your actual admin table
  return result.rows;
};

export const fetchTourismAttraction = async () => {
  const query = `
      SELECT * FROM TourismAttractions;
    `;
  const result = await pool.query(query);
  return result.rows;
};

export const addTourismAttraction = async (attraction) => {
  const query = `
      INSERT INTO TourismAttractions (TA_Name, Type_Code, Region, Prov_HUC, City_Mun, Report_Year, Brgy, Latitude, Longitude, TA_Category, NTDP_Category, Devt_Lvl, Mgt, Online_Connectivity)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
      RETURNING *;
    `;
  const values = [
    attraction.TA_Name, attraction.Type_Code, attraction.Region, attraction.Prov_HUC, attraction.City_Mun,
    attraction.Report_Year, attraction.Brgy, attraction.Latitude, attraction.Longitude, attraction.TA_Category,
    attraction.NTDP_Category, attraction.Devt_Lvl, attraction.Mgt, attraction.Online_Connectivity
  ];
  const result = await pool.query(query, values);
  return result.rows[0];
};

export const deleteTourismAttraction = async (id) => {
  const query = 'DELETE FROM TourismAttractions WHERE id = $1';
  await pool.query(query, [id]);
};

export const updateTourismAttraction = async (id, updatedAttraction) => {
  const query = `
      UPDATE TourismAttractions
      SET TA_Name = $1, Type_Code = $2, Region = $3, Prov_HUC = $4, City_Mun = $5, Report_Year = $6, Brgy = $7, Latitude = $8, Longitude = $9, TA_Category = $10, NTDP_Category = $11, Devt_Lvl = $12, Mgt = $13, Online_Connectivity = $14
      WHERE id = $15
      RETURNING *;
    `;
  const values = [
    updatedAttraction.TA_Name,
    updatedAttraction.Type_Code,
    updatedAttraction.Region,
    updatedAttraction.Prov_HUC,
    updatedAttraction.City_Mun,
    updatedAttraction.Report_Year,
    updatedAttraction.Brgy,
    updatedAttraction.Latitude,
    updatedAttraction.Longitude,
    updatedAttraction.TA_Category,
    updatedAttraction.NTDP_Category,
    updatedAttraction.Devt_Lvl,
    updatedAttraction.Mgt,
    updatedAttraction.Online_Connectivity,
    id, // Add the id as the 15th parameter
  ];
  const result = await pool.query(query, values);
  return result.rows[0];
};

export const fetchAnonymousUsers = async () => {

  const query = `
        SELECT * FROM anonymous_users
        ORDER BY is_Active DESC, created_at DESC;
    `;
  const result = await pool.query(query);
  return result.rows;
};

export const purgeAnonymousUsers = async () => {
  const query = 'DELETE FROM anonymous_users';
  await pool.query(query);
  return "anonymous_users successfully purged"
};


export const getEstablishmentEnglishNames = async () => {
  const query = 'SELECT id, est_name FROM establishments WHERE TRUE';
  const result = await pool.query(query);
  const formattedResult = result.rows.map(row => ({ id: row.id, est_name: row.est_name }));
  return formattedResult;
};

export const fetchOpenEndedSurveyResponses = async () => {
  try {
    const query = `
    SELECT sr.response_id, sr.anonymous_user_id, sr.surveyquestion_ref, sr.created_at, sr.is_analyzed, sr.response_value
    FROM survey_responses sr
    JOIN survey_questions sq ON sr.surveyquestion_ref = sq.surveyresponses_ref
    WHERE sq.questiontype = 'OPENENDED';
  `;
    const result = await pool.query(query);
    logger.warn(`OPEN-ENDED SURVEY RESPONSES: ${result.rows.length}`);
    return result.rows;
  } catch (err) {
    logger.error(err.message);
  }
};

// export const fetchAllSurveyResponses = async () => {
//   try {
//     const query = `
//       SELECT 
//         anonymous_user_id,
//         JSON_AGG(
//           JSON_BUILD_OBJECT(
//             'response_id', response_id,
//             'surveyquestion_ref', surveyquestion_ref,
//             'created_at', created_at,
//             'is_analyzed', is_analyzed,
//             'response_value', response_value
//           )
//         ) AS responses
//       FROM survey_responses
//       GROUP BY anonymous_user_id
//       ORDER BY anonymous_user_id;
//     `;
//     const result = await pool.query(query);
//     logger.info(`Fetched all survey responses, grouped by anonymous_user_id: ${result.rows.length} users found`);
//     return result.rows;
//   } catch (err) {
//     logger.error(`Error fetching all survey responses: ${err.message}`);
//     throw err;
//   }
// };
export const fetchSurveyQuestionsService = async () => {
  const query = `
    SELECT id, questiontype, survey_version, content, modified_date, title, surveyresponses_ref, surveytopic
    FROM survey_questions;
  `;
  const result = await pool.query(query);
  return result.rows;
};

