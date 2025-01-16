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
import https from 'https';
import fs from 'fs';
import cookieParser from 'cookie-parser';

dotenv.config();
const app = express();
app.use(express.json());
app.use(cookieParser());

const requiredEnvVars = ['PATH_TO_CERT', 'PATH_TO_KEY', 'FRONTEND_URL', 'PORT'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Environment variable ${envVar} is not set`);
  }
}
const corsOptions = {
  origin: true, // Explicitly allow your frontend origin
  optionsSuccessStatus: 200, // Some legacy browsers choke on 204
  credentials: true // Allow credentials (cookies, authorization headers, etc.)
};

app.use(cors(corsOptions));

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
  console.log('Cookies: ', req.cookies);
  const token = req.cookies.token; // Access the cookie
  if (token) {
      console.log('Token found in cookie:', token);
      res.send('Cookie is present and contains data.');
  } else {
      console.log('No token found in cookie.');
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