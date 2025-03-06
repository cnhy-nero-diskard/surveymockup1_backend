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
    logger.error({error: err.message});
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
    logger.error({error: err.message});
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
    logger.error({error: err.message});
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to create a new establishment entry in the database
export const createEstablishmentService = async (
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to fetch establishments based on optional filters
export const fetchEstablishmentsService = async (filters = {}) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to update an establishment entry
export const updateEstablishmentService = async (
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to delete an establishment entry by id
export const deleteEstablishmentService = async (id) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to create a new tourism attraction entry in the database
export const createTourismAttractionService = async (
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to fetch tourism attractions based on optional filters
export const fetchTourismAttractionsService = async (filters = {}) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to update a tourism attraction entry
export const updateTourismAttractionService = async (
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to delete a tourism attraction entry by id
export const deleteTourismAttractionService = async (id) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to create a new survey response entry
export const createSurveyResponseService = async (anonymous_user_id, surveyquestion_ref, response_value) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to fetch all survey responses
// Function to fetch survey responses with optional ID filter
export const fetchSurveyResponsesService = async (anonid = null) => {
  logger.database("METHOD api/admin/fetchSurveyResponses");
  try {
    let query = 'SELECT * FROM public.survey_responses';
    const values = [];

    if (anonid && typeof anonid === 'string') {
      query += ' WHERE anonymous_user_id = $1';
      values.push(anonid);
    }

    const result = await pool.query(query, values);
    // Always return all matching rows
    logger.warn(result.rowCount)
    return result.rows;
  } catch (err) {
    logger.error({error: err.message});
    throw err;
  }
};

// Function to update a survey response by response ID
export const updateSurveyResponseService = async (response_id, response_value) => {
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
    logger.error({error: err.message});
    throw err;
  }
};

// Function to delete a survey response by response ID
export const deleteSurveyResponseService = async (anonymous_user_id) => {
  logger.database("METHOD api/admin/deleteSurveyResponse");
  try {
    // SQL query to delete all survey response records for a given anonymous_user_id
    const query = `
      DELETE FROM public.survey_responses
      WHERE anonymous_user_id = $1 AND $1 IS NOT NULL
      RETURNING *;
    `;
    const values = [anonymous_user_id];
    const result = await pool.query(query, values);
    // Return all deleted survey response rows
    return result.rows;
  } catch (err) {
    logger.error({error: err.message});
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
    logger.error({error: err.message});
    throw err;
  }
};

export const deleteSurveyResponseServiceByUserId = async (anonymous_user_id) => {
  logger.database("METHOD api/admin/deleteSurveyResponse");
  try {
    const query = `
      DELETE FROM public.survey_responses
      WHERE anonymous_user_id = $1 AND $1 IS NOT NULL
      RETURNING *;
    `;
    const values = [anonymous_user_id];
    const result = await pool.query(query, values);
    return result.rows;
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// DISABLED -- SESSION MANAGER WILL BE THE ONLY SERVICE THAT CAN ADD STUFF IN THIS TABLE
// // Function to create a new anonymous user entry in the database
// export const createAnonymousUserService = async (anonymous_user_id, nickname) => {
//   logger.database("METHOD api/admin/anonymous_users - CREATE");
//   try {
//     // SQL query to insert a new anonymous user record
//     const query = `
//       INSERT INTO public.anonymous_users (anonymous_user_id, nickname)
//       VALUES ($1, $2)
//       RETURNING *;
//     `;
//     const values = [anonymous_user_id, nickname];
//     const result = await pool.query(query, values);
//     // Return the newly created row
//     return result.rows[0];
//   } catch (err) {
//     logger.error({ error: err.message });
//     throw err;
//   }
// };
// // Function to update an anonymous user entry
// export const updateAnonymousUserService = async (anonymous_user_id, nickname, is_active, current_step, has_completed) => {
//   logger.database("METHOD api/admin/anonymous_users - UPDATE");
//   try {
//     // SQL query to update an anonymous user record by id
//     const query = `
//       UPDATE public.anonymous_users
//       SET nickname = $1, is_active = $2, current_step = $3, has_completed = $4
//       WHERE anonymous_user_id = $5
//       RETURNING *;
//     `;
//     const values = [nickname, is_active, current_step, has_completed, anonymous_user_id];
//     const result = await pool.query(query, values);
//     // Return the updated row
//     return result.rows[0];
//   } catch (err) {
//     logger.error({ error: err.message });
//     throw err;
//   }
// };



// Function to fetch anonymous users based on optional filters
export const fetchAnonymousUsersService = async (filters = {}) => {
  logger.database("METHOD api/admin/anonymous_users - READ");
  try {
    let query = `SELECT * FROM public.anonymous_users`;
    const values = [];
    const conditions = [];

    // Add filters to the query if provided
    if (filters.anonymous_user_id) {
      conditions.push(`anonymous_user_id = $${values.length + 1}`);
      values.push(filters.anonymous_user_id);
    }
    if (filters.nickname) {
      conditions.push(`nickname ILIKE $${values.length + 1}`);
      values.push(`%${filters.nickname}%`);
    }

    // Append conditions to the query if any exist
    if (conditions.length > 0) {
      query += ` WHERE ${conditions.join(' AND ')}`;
    }

    const result = await pool.query(query, values);
    // Return all matching rows
    return result.rows;
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};


// Function to delete an anonymous user entry by id
export const deleteAnonymousUserService = async (anonymous_user_id) => {
  logger.database("METHOD api/admin/anonymous_users - DELETE");
  try {
    // SQL query to delete an anonymous user record by id
    const query = `
      DELETE FROM public.anonymous_users
      WHERE anonymous_user_id = $1
      RETURNING *;
    `;
    const values = [anonymous_user_id];
    const result = await pool.query(query, values);
    // Return the deleted row
    return result.rows[0];
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// Function to create a new sentiment analysis entry in the database
export const createSentimentAnalysisService = async (sentimentDataArray) => {
  logger.database("METHOD api/admin/sentiment_analysis - CREATE BULK");
  try {
    // SQL query to insert multiple sentiment analysis records
    const query = `
      INSERT INTO public.sentiment_analysis (user_id, review_date, rating, sqref, sentiment, confidence)
      VALUES ${sentimentDataArray.map((_, index) => `($${index * 6 + 1}, $${index * 6 + 2}, $${index * 6 + 3}, $${index * 6 + 4}, $${index * 6 + 5}, $${index * 6 + 6})`).join(', ')}
      RETURNING *;
    `;
    const values = sentimentDataArray.flat();
    const result = await pool.query(query, values);
    // Return the newly created rows
    return result.rows;
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// Function to fetch sentiment analysis entries based on optional filters
export const fetchSentimentAnalysisService = async (filters = {}) => {
  logger.database("METHOD api/admin/sentiment_analysis - READ");
  try {
    let query = `SELECT * FROM public.sentiment_analysis`;
    const values = [];
    const conditions = [];

    // Add filters to the query if provided
    if (filters.user_id) {
      conditions.push(`user_id = $${values.length + 1}`);
      values.push(filters.user_id);
    }
    if (filters.sqref) {
      conditions.push(`sqref = $${values.length + 1}`);
      values.push(filters.sqref);
    }
    if (filters.sentiment) {
      conditions.push(`sentiment = $${values.length + 1}`);
      values.push(filters.sentiment);
    }

    // Append conditions to the query if any exist
    if (conditions.length > 0) {
      query += ` WHERE ${conditions.join(' AND ')}`;
    }

    const result = await pool.query(query, values);
    // Return all matching rows
    return result.rows;
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// Function to update a sentiment analysis entry
export const updateSentimentAnalysisService = async (id, user_id, review_date, rating, sqref, sentiment, confidence) => {
  logger.database("METHOD api/admin/sentiment_analysis - UPDATE");
  try {
    // SQL query to update a sentiment analysis record by id
    const query = `
      UPDATE public.sentiment_analysis
      SET user_id = $1, review_date = $2, rating = $3, sqref = $4, sentiment = $5, confidence = $6
      WHERE id = $7
      RETURNING *;
    `;
    const values = [user_id, review_date, rating, sqref, sentiment, confidence, id];
    const result = await pool.query(query, values);
    // Return the updated row
    return result.rows[0];
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// Function to delete a sentiment analysis entry by id
export const deleteSentimentAnalysisService = async (id) => {
  logger.database("METHOD api/admin/sentiment_analysis - DELETE");
  try {
    // SQL query to delete a sentiment analysis record by id
    const query = `
      DELETE FROM public.sentiment_analysis
      WHERE id = $1
      RETURNING *;
    `;
    const values = [id];
    const result = await pool.query(query, values);
    // Return the deleted row
    return result.rows[0];
  } catch (err) {
    logger.error({ error: err.message });
    throw err;
  }
};

// Function to insert data into topics, top_words, and contributions tables
export const insertTopicDataService = async (data) => {
  logger.database("METHOD api/admin/insertTopicData");
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    for (const item of data) {
      const { topic, probability, top_words, customLabel, contribution } = item;

      // Insert into topics table
      const topicQuery = `
        INSERT INTO topics (topic_id, probability, custom_label)
        VALUES ($1, $2, $3)
        RETURNING id;
      `;
      const topicValues = [topic, probability, customLabel];
      const topicResult = await client.query(topicQuery, topicValues);
      const topicId = topicResult.rows[0].id;

      // Insert into top_words table
      const topWordsQuery = `
        INSERT INTO top_words (topic_id, word)
        VALUES ${top_words.map((_, index) => `($1, $${index + 2})`).join(', ')};
      `;
      const topWordsValues = [topicId, ...top_words];
      await client.query(topWordsQuery, topWordsValues);

      // Insert into contributions table
      for (const contrib of contribution) {
        const [relatedTopic, relatedLabel, contributionPercentage] = contrib;
        const contribQuery = `
          INSERT INTO contributions (topic_id, related_topic, related_label, contribution_percentage)
          VALUES ($1, $2, $3, $4);
        `;
        const contribValues = [topicId, relatedTopic, relatedLabel, parseFloat(contributionPercentage)];
        await client.query(contribQuery, contribValues);
      }
    }

    await client.query('COMMIT');
  } catch (err) {
    await client.query('ROLLBACK');
    logger.error({ error: err.message });
    throw err;
  } finally {
    client.release();
  }
};