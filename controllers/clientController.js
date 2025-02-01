/**
 * Get all municipalities.
 * 
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>}
 */
export const getMunicipalities = async (req, res, next) => {};

/**
 * Get all languages.
 * 
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>}
 */
export const getLanguageSelect = async (req, res, next) => {};

/**
 * Get localization texts based on language and component.
 * 
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>}
 */
export const getTexts = async (req, res, next) => {};

/**
 * Get survey progress for an anonymous user.
 * 
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>}
 */
export const getSurveyProgress = async (req, res, next) => {};

/**
 * Update survey progress for an anonymous user.
 * 
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 * @param {Function} next - Express next middleware function.
 * @returns {Promise<void>}
 */
export const updateSurveyProgress = async (req, res, next) => {};
// controllers/clientController.js
import pool from "../config/db.js";
import logger from "../middleware/logger.js";








getMunicipalities = async (req, res, next) => {
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

getLanguageSelect = async (req, res, next) => {
    logger.info("GET /api/languages");
    try {
        const query = 'SELECT * FROM languages';
        const result = await pool.query(query);
        res.json(result.rows);
    } catch (err) {
        next(err);
    }
};
getTexts = async (req, res, next) => {
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
        logger.toclient(`SENT LOCALIZATION TEXTS TO ${req.session.anonymousUserId}`)
        res.json(translations);
    } catch (err) {
        next(err);
    }
};

getSurveyProgress = async (req,res,next) => {
    logger.toclient("GET INITIAL PROGRESS");
    const { user_id } = req.session.anonymousUserId; // Assuming you have user authentication
    try {
      const result = await pool.query(
        "SELECT current_step FROM anonymous_users WHERE anonymous_user_id = $1",
        [user_id]
      );
      if (result.rows.length > 0) {
        res.json({ currentStep: result.rows[0].current_step });
      } else {
        // MIGHT NOT BE NECESSARY TBH
        await pool.query(
            "UPDATE anonymous_users SET current_step = 0 WHERE anonymous_user_id = $1",
            [user_id]
          );
        res.status(200).json({ currentStep: 0 });
      }
    } catch (err) {
      logger.error(err.message);
      res.status(500).send("Server error");
    };
};

updateSurveyProgress = async (req, res, next) => {
    logger.toclient("POST updateSurveyProgress");
    const { user_id } = req.session.anonymousUserId;
    const { currentStep } = req.body;
    try {
      await pool.query(
        "UPDATE anonymous_users SET current_step = $1 WHERE anonymous_user_id = $2",
        [currentStep, user_id]
      );
      res.status(200).json({ message: "Progress updated" });
    } catch (err) {
      console.error(err.message);
      res.status(500).send("Server error");
    }
}