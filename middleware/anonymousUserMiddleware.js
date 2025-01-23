// middleware/anonymousUserMiddleware.js
import { v4 as uuidv4 } from 'uuid';
import pool from '../config/db.js';
import logger from './logger.js';
import dotenv from 'dotenv';

dotenv.config();

export const generateAnonymousUserId = async (req, res, next) => {
    logger.info('Generate anonymous user ID');
    try {
        let anonymousUserId = req.cookies.anonymousUserId;

        // If the anonymousUserId cookie doesn't exist, generate a new one
        if (!anonymousUserId) {
            anonymousUserId = uuidv4(); // Generate a UUID
            logger.info(`Created new anonymous user ID: ${anonymousUserId}`);

            // Insert the anonymous user into the database
            await pool.query(
                'INSERT INTO anonymous_users (anonymous_user_id, is_active) VALUES ($1, $2)',
                [anonymousUserId, true] // Set is_active to true for new users
            );

            // Set the anonymousUserId cookie
            res.cookie('anonymousUserId', anonymousUserId, {
                httpOnly: true,
                secure: process.env.NODE_ENV === 'production',
                sameSite: 'strict',
                path: '/',
                maxAge: 30 * 24 * 60 * 60 * 1000, // 30 days expiration
            });
        } else {
            // If the anonymousUserId exists, update is_active to true
            await pool.query(
                'UPDATE anonymous_users SET is_active = TRUE WHERE anonymous_user_id = $1',
                [anonymousUserId]
            );
            logger.info(`Updated anonymous user ID ${anonymousUserId} to active`);
        }

        // Schedule a task to mark the user as inactive after 1 minute
        setTimeout(async () => {
            try {
                await pool.query(
                    'UPDATE anonymous_users SET is_active = FALSE WHERE anonymous_user_id = $1',
                    [anonymousUserId]
                );
                logger.info(`Marked anonymous user ID ${anonymousUserId} as inactive`);
            } catch (error) {
                logger.error(`Error marking anonymous user ID ${anonymousUserId} as inactive:`, error);
            }
        }, 60000); // 1 minute

        next(); // Proceed to the next middleware or route handler
    } catch (err) {
        next(err); // Pass the error to the error handler
    }
};