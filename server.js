/**
 * @file server.js
 * @description This file sets up and configures the Express server for the Survey Mockup application. It includes middleware for security, session management, logging, and error handling. It also defines routes for client, admin, and authentication functionalities.
 * 
 * @requires express
 * @requires cors
 * @requires dotenv
 * @requires ./routes/clientRoutes.js
 * @requires ./routes/adminRoutes.js
 * @requires ./middleware/errorHandler.js
 * @requires ./routes/authRoutes.js
 * @requires ./middleware/logger.js
 * @requires helmet
 * @requires express-rate-limit
 * @requires cookie-parser
 * @requires ./middleware/updateAnonymousUserActivity.js
 * @requires ./middleware/anonymousUserMiddleware.js
 * @requires body-parser
 * @requires express-session
 * @requires ./config/db.js
 * @requires connect-pg-simple
 * @requires ./controllers/adminController.js
 */

/**
 * @constant {Array<string>} requiredEnvVars - List of required environment variables.
 */

/**
 * @throws Will throw an error if any of the required environment variables are not set.
 */

/**
 * @constant {Function} PgSession - PostgreSQL session store for Express.
 */

/**
 * @constant {Object} app - Express application instance.
 */

/**
 * @middleware
 * @function
 * @name express.json
 * @description Middleware to parse incoming JSON requests.
 */

/**
 * @middleware
 * @function
 * @name cors
 * @description Middleware to enable CORS with specific configuration.
 * @param {Object} options - CORS configuration options.
 */

/**
 * @middleware
 * @function
 * @name cookieParser
 * @description Middleware to parse cookies attached to the client request object.
 */

/**
 * @middleware
 * @function
 * @name session
 * @description Middleware to handle sessions using PostgreSQL as the store.
 * @param {Object} options - Session configuration options.
 */

/**
 * @middleware
 * @function
 * @name handleAnonymousUser
 * @description Middleware to handle anonymous user sessions.
 */

/**
 * @middleware
 * @function
 * @name clientRoutes
 * @description Routes for client-side functionalities.
 */

/**
 * @middleware
 * @function
 * @name adminRoutes
 * @description Routes for admin-side functionalities.
 */

/**
 * @middleware
 * @function
 * @name errorHandler
 * @description Middleware to handle errors.
 */

/**
 * @middleware
 * @function
 * @name authRoutes
 * @description Routes for authentication functionalities.
 */

/**
 * @middleware
 * @function
 * @name helmet
 * @description Middleware to set various HTTP headers for security.
 */

/**
 * @constant {Object} limiter - Rate limiting configuration.
 * @param {number} windowMs - Time window in milliseconds.
 * @param {number} max - Maximum number of requests per windowMs.
 */

/**
 * @route GET /verify-cookie
 * @description Route to verify the presence of a specific cookie.
 * @param {Object} req - Express request object.
 * @param {Object} res - Express response object.
 */

/**
 * @constant {number} PORT - Port number on which the server listens.
 */

/**
 * @function
 * @name listen
 * @description Starts the server and listens on the specified port.
 * @param {number} PORT - Port number.
 * @param {Function} callback - Callback function to execute once the server starts.
 */
// server.js
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import clientRoutes from './routes/clientRoutes.js';
import adminRoutes from './routes/adminRoutes.js';
import { errorHandler } from './middleware/errorHandler.js';
import authRoutes from './routes/authRoutes.js';
import logger from './middleware/logger.js';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import cookieParser from 'cookie-parser';
import { updateAnonymousUserActivity } from './middleware/updateAnonymousUserActivity.js';
import { handleAnonymousUser } from './middleware/anonymousUserMiddleware.js';
import bodyParser from 'body-parser';
import session from 'express-session';
import pool from './config/db.js';
import pgSession from 'connect-pg-simple';
import { logstream } from './controllers/adminController.js';

const requiredEnvVars = ['PATH_TO_CERT', 'PATH_TO_KEY', 'FRONTEND_URL', 'PORT'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Environment variable ${envVar} is not set`);
  }
}

dotenv.config();
const PgSession = pgSession(session);
const app = express();



app.use(express.json());
app.use(cors({
  origin: process.env.FRONTEND_URL, // Allow requests from your React frontend
  credentials: true, // Allow cookies to be sent
  
}));



app.use(cookieParser());
app.use('/api/log-stream', logstream)
app.use(
  session({
    store: new PgSession({
      pool: pool, // Provide the pool object from the database connection
      tableName: 'anonymous_session', // Name of the table to store sessions (default is "session")
    }),
    secret: process.env.SESSION_SECRET, // Replace with a secure secret
    resave: false,
    saveUninitialized: false,
    cookie: {
      maxAge: 1000 * 60 * 60 * 24 * 7, // 1 day
      secure: false, // Set to true if using HTTPS
    },
  })
);
app.use(handleAnonymousUser);


// Use client routes
app.use('/', clientRoutes);

// Use admin routes
app.use('/', adminRoutes);
app.use(errorHandler);

//authentication routes
app.use(authRoutes);



app.use(helmet());

//rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use(limiter);
app.get('/verify-cookie', (req, res) => {
  logger.info('Cookies: ', req.cookies);
  const token = req.cookies.token; // Access the cookie
  if (token) {
      logger.info('Token found in cookie:', token);
      res.send('Cookie is present and contains data.');
  } else {
      logger.info('No token found in cookie.');
      res.status(400).send('Cookie is missing or empty.');
  }
});


// Start the server
const PORT = 5000;
app.listen(PORT, () => {
    logger.info(`Server is running on port ${process.env.PORT}`);
});

