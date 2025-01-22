// controllers/clientController.js
import pool from "../config/db.js";
import logger from "../middleware/logger.js";

export const getMunicipalities = async (req, res, next) => {
    logger.info("GET /api/municipalities");
    if (!process.env.PG_MUNICIPALITIES) {
        return next(new Error('PG_MUNICIPALITIES environment variable is not set')); // Pass error to error handler
    }
    try {
        const tablemunquery = `SELECT * FROM ${process.env.PG_MUNICIPALITIES}`;
        const result = await pool.query(tablemunquery);
        res.json(result.rows);
    } catch (err) {
        next(err); 
    }
};

export const getLanguageSelect = async (req, res, next) => {
    logger.info("GET /api/languages");
    try {
        const query = 'SELECT * FROM languages';
        const result = await pool.query(query);
        res.json(result.rows);
        logger.info(result.rows);
    } catch (err) {
        next(err);
    }
};

export const getTexts = async (req, res, next) => {
    logger.info("GET /api/texts");
    const language = req.query.language || 'en';
    const component = req.query.component || 'mainpurpose';
    try {
        const query = `
      SELECT key, textcontent 
      FROM ${process.env.PG_LOCALIZATION} 
      WHERE language_code = $1 AND component = $2
    `;
        const result = await pool.query(query, [language, component]);
        const translations = result.rows.reduce((acc, row) => {
            acc[row.key] = row.textcontent;
            return acc;
        }, {});
        res.json(translations);
        logger.info(translations);
    } catch (err) {
        next(err);
    }
};