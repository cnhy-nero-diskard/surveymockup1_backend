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

dotenv.config();
const PgSession = pgSession(session);
const app = express();



app.use(express.json());
app.use(cors({
  origin: 'http://localhost:3000', // Allow requests from your React frontend
  credentials: true, // Allow cookies to be sent
}));
app.use(cookieParser());



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
      maxAge: 1000 * 60 * 60 * 24, // 1 day
      secure: false, // Set to true if using HTTPS
    },
  })
);
app.use(handleAnonymousUser);

// app.use(updateAnonymousUserActivity); // Apply globally


const requiredEnvVars = ['PATH_TO_CERT', 'PATH_TO_KEY', 'FRONTEND_URL', 'PORT'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Environment variable ${envVar} is not set`);
  }
}


// Use client routes
app.use('/', clientRoutes);

// Use admin routes
app.use('/', adminRoutes);
app.use(errorHandler);

//authentication routes
app.use(authRoutes);


//cors and helmet for security

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

// const options = {
//   key: fs.readFileSync(process.env.PATH_TO_KEY), // Path to your private key
//   cert: fs.readFileSync(process.env.PATH_TO_CERT), // Path to your certificate
// };

// https.createServer(options, app).listen(process.env.PORT, () => {
//   logger.info(`Server is running on port ${process.env.PORT}`);
// });