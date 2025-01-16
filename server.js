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

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());



// Use client routes
app.use('/', clientRoutes);

// Use admin routes
app.use('/', adminRoutes);
app.use(errorHandler);

//authentication routes
app.use(authRoutes);


//cors and helmet for security
const corsOptions = {
  origin: process.env.FRONTEND_URL || "http://localhost:3000", 
  optionsSuccessStatus: 200, // Some legacy browsers choke on 204
  credentials: true
};
app.use(helmet());
app.use(cors( {
  origin: process.env.FRONTEND_URL || "http://localhost:3000", 
  optionsSuccessStatus: 200, // Some legacy browsers choke on 204
  credentials: true
}));


//rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use(limiter);
app.get('/verify-cookie', (req, res) => {
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