import pool from "../config/db.js";
import logger from "../middleware/logger.js";



// Function to create a new localization entry in the database
export const createLocalizationService = async (key, language_code, textContent, component) => {
  logger.database("METHOD api/admin/localization - CREATE");
  try {
    // SQL query to insert a new localization record
    const query = `
      INSERT INTO public.localization00 (key, language_code, textcontent, component)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    const values = [key, language_code, textContent, component];
    // Execute the query with the provided values
    const result = await pool.query(query, values);
    // Return the newly created row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch localizations based on optional filters
export const fetchLocalizationsService = async (filters = {}) => {
  logger.database("METHOD api/admin/localization - READ");
  try {
    let query = `SELECT * FROM public.localization00`;
    const values = [];
    const conditions = [];
  
    // Add filters to the query if provided
    if (filters.key) {
      conditions.push(`key = $${values.length + 1}`);
      values.push(filters.key);
    }
    if (filters.languageCode) {
      conditions.push(`language_code = $${values.length + 1}`);
      values.push(filters.languageCode);
    }
    if (filters.component) {
      conditions.push(`component = $${values.length + 1}`);
      values.push(filters.component);
    }
  
    // Append conditions to the query if any exist
    if (conditions.length > 0) {
      query += ` WHERE ${conditions.join(' AND ')}`;
    }
  
    const result = await pool.query(query, values);
    // Return all matching rows
    return result.rows;
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to update a localization entry
export const updateLocalizationService = async (id, key, languageCode, textContent, component) => {
  logger.database("METHOD api/admin/localization - UPDATE");
  try {
    // SQL query to update a localization record by id
    const query = `
      UPDATE public.localization00
      SET key = $1, language_code = $2, textcontent = $3, component = $4
      WHERE id = $5
      RETURNING *;
    `;
    const values = [key, languageCode, textContent, component, id];
    const result = await pool.query(query, values);
    // Return the updated row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to delete a localization entry by id
export const deleteLocalizationService = async (id) => {
  logger.database("METHOD api/admin/localization - DELETE");
  try {
    // SQL query to delete a localization record by id
    const query = `
      DELETE FROM public.localization00
      WHERE id = $1
      RETURNING *;
    `;
    const values = [id];
    const result = await pool.query(query, values);
    // Return the deleted row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to create a new establishment entry in the database
export const createEstablishment = async (
  estName, type, cityMun, barangay, latitude, longitude,
  english, korean, chinese, japanese, russian, french, spanish, hindi
) => {
  logger.database("METHOD api/admin/establishments - CREATE");
  try {
    // SQL query to insert a new establishment record
    const query = `
      INSERT INTO public.establishments (
        est_name, type, city_mun, barangay, latitude, longitude,
        english, korean, chinese, japanese, russian, french, spanish, hindi
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
      RETURNING *;
    `;
    const values = [
      estName, type, cityMun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi
    ];
    const result = await pool.query(query, values);
    // Return the newly created row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch establishments based on optional filters
export const fetchEstablishments = async (filters = {}) => {
  logger.database("METHOD api/admin/establishments - READ");
  try {
    let query = `SELECT * FROM public.establishments`;
    const values = [];
    const conditions = [];
  
    // Add filters to the query if provided
    if (filters.estName) {
      conditions.push(`est_name ILIKE $${values.length + 1}`);
      values.push(`%${filters.estName}%`);
    }
    if (filters.type) {
      conditions.push(`type = $${values.length + 1}`);
      values.push(filters.type);
    }
    if (filters.cityMun) {
      conditions.push(`city_mun = $${values.length + 1}`);
      values.push(filters.cityMun);
    }
    if (filters.barangay) {
      conditions.push(`barangay = $${values.length + 1}`);
      values.push(filters.barangay);
    }
  
    // Append conditions to the query if any exist
    if (conditions.length > 0) {
      query += ` WHERE ${conditions.join(' AND ')}`;
    }
  
    const result = await pool.query(query, values);
    // Return all matching rows
    return result.rows;
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to update an establishment entry
export const updateEstablishment = async (
  id, estName, type, cityMun, barangay, latitude, longitude,
  english, korean, chinese, japanese, russian, french, spanish, hindi
) => {
  logger.database("METHOD api/admin/establishments - UPDATE");
  try {
    // SQL query to update an establishment record by id
    const query = `
      UPDATE public.establishments
      SET
        est_name = $1, type = $2, city_mun = $3, barangay = $4, latitude = $5, longitude = $6,
        english = $7, korean = $8, chinese = $9, japanese = $10, russian = $11, french = $12, spanish = $13, hindi = $14
      WHERE id = $15
      RETURNING *;
    `;
    const values = [
      estName, type, cityMun, barangay, latitude, longitude,
      english, korean, chinese, japanese, russian, french, spanish, hindi, id
    ];
    const result = await pool.query(query, values);
    // Return the updated row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to delete an establishment entry by id
export const deleteEstablishment = async (id) => {
  logger.database("METHOD api/admin/establishments - DELETE");
  try {
    // SQL query to delete an establishment record by id
    const query = `
      DELETE FROM public.establishments
      WHERE id = $1
      RETURNING *;
    `;
    const values = [id];
    const result = await pool.query(query, values);
    // Return the deleted row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to create a new tourism attraction entry in the database
export const createTourismAttraction = async (
  taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
  latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
) => {
  logger.database("METHOD api/admin/tourismattractions - CREATE");
  try {
    // SQL query to insert a new tourism attraction record
    const query = `
      INSERT INTO public.tourismattractions (
        ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
        latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
      RETURNING *;
    `;
    const values = [
      taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
      latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
    ];
    const result = await pool.query(query, values);
    // Return the newly created row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch tourism attractions based on optional filters
export const fetchTourismAttractions = async (filters = {}) => {
  logger.database("METHOD api/admin/tourismattractions - READ");
  try {
    let query = `SELECT * FROM public.tourismattractions`;
    const values = [];
    const conditions = [];
  
    // Add filters to the query if provided
    if (filters.taName) {
      conditions.push(`ta_name ILIKE $${values.length + 1}`);
      values.push(`%${filters.taName}%`);
    }
    if (filters.typeCode) {
      conditions.push(`type_code = $${values.length + 1}`);
      values.push(filters.typeCode);
    }
    if (filters.region) {
      conditions.push(`region = $${values.length + 1}`);
      values.push(filters.region);
    }
    if (filters.cityMun) {
      conditions.push(`city_mun = $${values.length + 1}`);
      values.push(filters.cityMun);
    }
    if (filters.reportYear) {
      conditions.push(`report_year = $${values.length + 1}`);
      values.push(filters.reportYear);
    }
    if (filters.taCategory) {
      conditions.push(`ta_category = $${values.length + 1}`);
      values.push(filters.taCategory);
    }
  
    // Append conditions to the query if any exist
    if (conditions.length > 0) {
      query += ` WHERE ${conditions.join(' AND ')}`;
    }
  
    const result = await pool.query(query, values);
    // Return all matching rows
    return result.rows;
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to update a tourism attraction entry
export const updateTourismAttraction = async (
  id, taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
  latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
) => {
  logger.database("METHOD api/admin/tourismattractions - UPDATE");
  try {
    // SQL query to update a tourism attraction record by id
    const query = `
      UPDATE public.tourismattractions
      SET
        ta_name = $1, type_code = $2, region = $3, prov_huc = $4, city_mun = $5, report_year = $6, brgy = $7,
        latitude = $8, longitude = $9, ta_category = $10, ntdp_category = $11, devt_lvl = $12, mgt = $13, online_connectivity = $14
      WHERE id = $15
      RETURNING *;
    `;
    const values = [
      taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
      latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity, id
    ];
    const result = await pool.query(query, values);
    // Return the updated row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to delete a tourism attraction entry by id
export const deleteTourismAttraction = async (id) => {
  logger.database("METHOD api/admin/tourismattractions - DELETE");
  try {
    // SQL query to delete a tourism attraction record by id
    const query = `
      DELETE FROM public.tourismattractions
      WHERE id = $1
      RETURNING *;
    `;
    const values = [id];
    const result = await pool.query(query, values);
    // Return the deleted row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to create a new survey response entry
export const createSurveyResponse = async (anonymous_user_id, surveyquestion_ref, response_value) => {
  logger.database("METHOD api/admin/createSurveyResponse");
  try {
    // SQL query to insert a new survey response record
    const query = `
      INSERT INTO public.survey_responses (anonymous_user_id, surveyquestion_ref, response_value)
      VALUES ($1, $2, $3)
      RETURNING *;
    `;
    const values = [anonymous_user_id, surveyquestion_ref, response_value];
    const result = await pool.query(query, values);
    // Return the newly created row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch all survey responses
export const fetchAllSurveyResponses = async () => {
  logger.database("METHOD api/admin/fetchAllSurveyResponses");
  try {
    const query = `
      SELECT * FROM public.survey_responses;
    `;
    const result = await pool.query(query);
    // Return all survey response rows
    return result.rows;
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch a single survey response by its ID
export const fetchSurveyResponseById = async (response_id) => {
  logger.database("METHOD api/admin/fetchSurveyResponseById");
  try {
    const query = `
      SELECT * FROM public.survey_responses
      WHERE response_id = $1;
    `;
    const values = [response_id];
    const result = await pool.query(query, values);
    // Return the matching survey response row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to update a survey response by response ID
export const updateSurveyResponse = async (response_id, response_value) => {
  logger.database("METHOD api/admin/updateSurveyResponse");
  try {
    // SQL query to update a survey response record
    const query = `
      UPDATE public.survey_responses
      SET response_value = $1
      WHERE response_id = $2
      RETURNING *;
    `;
    const values = [response_value, response_id];
    const result = await pool.query(query, values);
    // Return the updated survey response row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to delete a survey response by response ID
export const deleteSurveyResponse = async (response_id) => {
  logger.database("METHOD api/admin/deleteSurveyResponse");
  try {
    // SQL query to delete a survey response record
    const query = `
      DELETE FROM public.survey_responses
      WHERE response_id = $1
      RETURNING *;
    `;
    const values = [response_id];
    const result = await pool.query(query, values);
    // Return the deleted survey response row
    return result.rows[0];
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};

// Function to fetch survey responses by user ID and question reference
export const fetchResponsesByUserAndQuestion = async (anonymous_user_id, surveyquestion_ref) => {
  logger.database("METHOD api/admin/fetchResponsesByUserAndQuestion");
  try {
    const query = `
      SELECT * FROM public.survey_responses
      WHERE anonymous_user_id = $1 AND surveyquestion_ref = $2;
    `;
    const values = [anonymous_user_id, surveyquestion_ref];
    const result = await pool.query(query, values);
    // Return all matching survey response rows
    return result.rows;
  } catch (err) {
    logger.error(err.message);
    throw err;
  }
};
