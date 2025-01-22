// controllers/adminController.js
import { getAdminDataFromDB, updateTourismAttraction, addTourismAttraction, fetchTourismAttraction, deleteTourismAttraction } from '../services/adminService.js';
import logger from '../middleware/logger.js';
import { validationResult } from 'express-validator';
import pool from '../config/db.js';

export const getAdminData = async (req, res, next) => {
    logger.info("GET /api/admin/data");
    try {
        const data = await getAdminDataFromDB();
        res.json(data);
    } catch (err) {
        next(err); // Pass error to error handler
    }
};

export const addTourismAttractionController = async (req, res, next) => {
    logger.info("POST /api/admin/add");
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() }); // Validation errors are still sent directly
    }
  
    try {
      const newAttraction = req.body;
      const result = await addTourismAttraction(newAttraction);
      res.status(201).json(result);
    } catch (err) {
      next(err); // Pass error to error handler
    }
};

export const fetchTourismAttractionsController = async (req, res, next) => {
    logger.info("GET /api/admin/fetch");
    try {
        const attractions = await fetchTourismAttraction();
        res.json(attractions);
    } catch (err) {
        next(err);
    }
}


export const deleteTourismAttractionController = async (req, res, next) => {
    logger.info("DELETE /api/admin/delete/:id");
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
    }

    try {
        const response = req.body;
        const result = await submitSurveyResponse(response);
        res.status(201).json(result);
    } catch (err) {
        console.error('Error submitting survey response:', err);
        res.status(500).json({ error: 'Failed to submit survey response' });
    }
};

export const updateTourismAttractionController = async (req, res, next) => {
    logger.info("PUT /api/admin/update/:id");
    try {
        const { id } = req.params;
        const updatedAttraction = req.body;
        const result = await updateTourismAttraction(id, updatedAttraction);
        res.json(result);
    } catch (err) {
        next(err);
    }
};

export const getAdminSessionData = async (req, res, next) => {
    logger.info("GET /api/admin/session-data");
    try {
        const result = await pool.query('SELECT username, last_login, last_logout, session_duration, is_logged_in FROM admin_table');
        res.json(result.rows);
    } catch (err) {
        next(err);
    }
};