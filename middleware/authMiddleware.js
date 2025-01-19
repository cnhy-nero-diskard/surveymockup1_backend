import jwt from 'jsonwebtoken';

export const authenticate = (req, res, next) => {
    const token = req.cookies?.token;

    if (!token || typeof token !== 'string' || token.trim() === '') {
        return res.status(401).json({ error: 'Unauthorized' });
    }

    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    } catch (err) {
        if (err.name === 'TokenExpiredError') {
            return res.status(401).json({ error: 'Token expired.' });
        }
        res.status(400).json({ error: 'Unauthorized' });
    }
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

