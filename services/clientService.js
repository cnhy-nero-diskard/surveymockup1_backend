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