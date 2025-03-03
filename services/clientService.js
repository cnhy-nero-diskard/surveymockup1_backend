// services/clientService.js
import pool from '../config/db.js';

export const getMunicipalitiesFromDB = async () => {
  const tablemunquery = `SELECT * FROM ${process.env.PG_MUNICIPALITIES}`;
  const result = await pool.query(tablemunquery);
  return result.rows;
};

export const getLanguagesFromDB = async () => {
  const result = await pool.query('SELECT * FROM languages');
  return result.rows;
};

export const getTextsFromDB = async (language, component) => {
  const query = `SELECT key, textcontent FROM ${process.env.PG_LOCALIZATION} WHERE language_code = '${language}' AND component = '${component}'`;
  const result = await pool.query(query);
  return result.rows;
};

export const getTourismAttractionLocalizations = async (languageCode) => {
  try {
    // First, get the language_id from the languages table using the languageCode
    const languageQuery = 'SELECT id FROM languages WHERE code = $1';
    const languageResult = await pool.query(languageQuery, [languageCode]);

    if (languageResult.rows.length === 0) {
      throw new Error(`Language code '${languageCode}' not found`);
    }

    const languageId = languageResult.rows[0].id;

    // Now, query the tourismattraction_localizations and tourismattractions tables using the language_id
    const localizationQuery = `
      SELECT 
        ta_l.translated_name, 
        ta.brgy, 
        ta.city_mun, 
        ta.prov_huc, 
        ta.region
      FROM 
        tourismattraction_localizations ta_l
      JOIN 
        tourismattractions ta 
      ON 
        ta_l.tourism_attraction_id = ta.id
      WHERE 
        ta_l.language_id = $1
    `;
    const localizationResult = await pool.query(localizationQuery, [languageId]);

    // Format the results into key-value pairs
    const result = localizationResult.rows.map(row => ({
      [row.translated_name]: `${row.brgy}, ${row.city_mun}, ${row.prov_huc}, ${row.region}`
    }));

    // Return the formatted results
    return result;
  } catch (err) {
    throw err;
  }
};
