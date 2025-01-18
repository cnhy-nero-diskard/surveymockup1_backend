// controllers/authController.js
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import pool from '../config/db.js';
import logger from '../middleware/logger.js';
import dotenv from 'dotenv';
dotenv.config();
export const login = async (req, res, next) => {
    const { username, password } = req.body;
    logger.info(`POST /api/auth/login for username: ${username}`);

    try {
        const result = await pool.query('SELECT * FROM admin_table WHERE username = $1', [username]);
        const admin = result.rows[0];

        if (!admin) {
            logger.warn(`Admin with username ${username} not found`);
            return res.status(400).json({ error: 'Invalid username or password.' });
        }

        const validPassword = await bcrypt.compare(password, admin.e_password);
        if (!validPassword) {
            logger.warn(`Invalid password for admin with username ${username}`);
            return res.status(400).json({ error: 'Invalid username or password.' });
        }

        const token = jwt.sign({ username: admin.username }, process.env.JWT_SECRET, {
            expiresIn: '1h',
        });

        // Update last_login and is_logged_in
        await pool.query('UPDATE admin_table SET last_login = NOW(), is_logged_in = TRUE WHERE username = $1', [username]);

        // Set the token in an HttpOnly cookie
        res.cookie('token', token, {
            httpOnly: true, // Prevent JavaScript access
            secure: process.env.NODE_ENV === 'production', // Only send over HTTPS in production
            sameSite: 'strict', // Prevent CSRF attacks
            maxAge: 3600000, // 1 hour expiration
            path: '/', // Ensure the cookie is sent for all routes
        }).status(200).send('OK');
        console.log('Response Headers:', res.getHeaders());

        logger.info(`Admin with username ${username} logged in successfully with token: ${token}`);

    } catch (err) {
        next(err);
    }
};
export const logout = async (req, res, next) => {
    const { username } = req.user; // Assuming the user is attached to the request by the auth middleware

    try {
        const result = await pool.query('SELECT last_login FROM admin_table WHERE username = $1', [username]);
        const lastLogin = result.rows[0].last_login;

        const sessionDuration = Math.floor((new Date() - lastLogin) / 1000); // Duration in seconds

        await pool.query('UPDATE admin_table SET last_logout = NOW(), session_duration = $1, is_logged_in = FALSE WHERE username = $2', [sessionDuration, username]);

        // Clear the token cookie
        res.clearCookie('token', {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: 'Lax',
            
        });

        res.json({ message: 'Logged out successfully' });
    } catch (err) {
        next(err);
    }
}; export const registerAdmin = async (req, res) => {
    const { username, password, email } = req.body;
    logger.info(`POST /api/auth/register for password: ${password} and username: ${username}    email: ${email}`);
    try {
        // Hash the password
        logger.info('Hashing password');
        const saltRounds = 10; // Number of salt rounds for hashing
        const hashedPassword = await bcrypt.hash(password, saltRounds);
        logger.info('Password hashed');

        // Insert the admin into the database
        try {
            const query = `
        INSERT INTO admin_table (username, e_password, gmail)
        VALUES ($1, $2, $3)
        RETURNING *;
      `;
            const values = [username, hashedPassword, email];
            const result = await pool.query(query, values);
            res.json(`Admin successfully registered with username: ${username}`);
            return result.rows[0]; // Return the newly created admin

        } catch (error) {
            logger.error('Error registering admin:', error);
        }
    } catch (err) {
        logger.error('Error registering admin:', err);
        throw err; // Pass the error to the caller
    }
};

