import jwt from 'jsonwebtoken';
import logger from './logger.js';

export const authenticate = (req, res, next) => {
    const token = req.cookies?.token;


    if (!token || typeof token !== 'string' || token.trim() === '') {
        return res.status(401).json({ error: 'UNAUTHORIZED: ' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // Attach the decoded user to the request object
        next();
    } catch (err) {
        if (err.name === 'TokenExpiredError') {
            return res.status(401).json({ error: 'Token expired.' });
        }
        res.status(400).json({ error: 'YOU R Unauthorized' });
    }
    logger.admin('Token found in cookie. AUTHENTICATED');
};

export const authorizeAdmin = (req, res, next) => {
    if (!req.user?.role) {
        return res.status(403).json({ error: 'Unauthorized' });
    }

    if (req.user.role !== 'admin') {
        return res.status(403).json({ error: 'Forbidden' });
    }

    next();
};

