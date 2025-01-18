// middleware/authMiddleware.js
import jwt from 'jsonwebtoken';
// import cookie from 'cookie-parser'; // Import the cookie parser

export const authenticate = (req, res, next) => {
    // Parse the cookies from the request headers
    // const cookies = cookie.parse(req.headers.cookie || '');

    const cookies = req.cookies || ''; // Extract the token from the cookies
   
    console.log('HEADER:', req.headers);
    console.log('COOKIE: ', cookies);
    const token = cookies.token || '';

    if (!token) {
        console.log(res.getHeaders());
        return res.status(401).json({ error: 'Access denied. No token provided.' });
    }

    try {
        // Verify the token
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded; // Attach the decoded user to the request object
        next();
    } catch (err) {
        res.status(400).json({ error: 'Invalid token.' });
    }
};

export const authorizeAdmin = (req, res, next) => {
    // Check if the user object exists and has a role property
    if (!req.user || !req.user.role) {
        return res.status(403).json({ error: 'Access denied. User information missing.' });
    }

    // Check if the user has the 'admin' role
    if (req.user.role !== 'admin') {
        return res.status(403).json({ error: 'Access denied. Admin privileges required.' });
    }

    // If the user is an admin, proceed to the next middleware or route handler
    next();
};

export default { authenticate, authorizeAdmin };