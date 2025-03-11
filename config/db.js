
// config/db.js
import pg from 'pg';
import dotenv from 'dotenv';
import logger from '../middleware/logger.js';

dotenv.config();

const requiredEnvVars = ['PG_USER', 'PG_HOST', 'PG_DATABASE', 'PG_PASSWORD', 'PG_PORT', 'JWT_SECRET'];

// Check for required environment variables
try {
  for (const envVar of requiredEnvVars) {
    if (!process.env[envVar]) {
      throw new Error(`Environment variable ${envVar} is not set`);
    }
  }
} catch (err) {
  console.error('Missing environment variables:', err.message);
  process.exit(1); // Exit with error code
}

/**
 * Creates a new PostgreSQL connection pool using the provided configuration.
 * 
 * The configuration is sourced from environment variables:
 * - PG_USER: The username for the PostgreSQL database.
 * - PG_HOST: The host address of the PostgreSQL database.
 * - PG_DATABASE: The name of the PostgreSQL database.
 * - PG_PASSWORD: The password for the PostgreSQL database.
 * - PG_PORT: The port number on which the PostgreSQL database is running.
 * 
 * @type {pg.Pool}
 */
let pool;

try {
  pool = new pg.Pool({
    user: process.env.PG_USER,
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
    // Optional: Add connection timeout
    connectionTimeoutMillis: 5000,
  });

  // Handle connection errors
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err);
    // Optional: You can attempt to re-connect here
    // or just let the pool handle it internally
  });

  // Optional: Handle successful connection
  pool.on('connect', () => {
    logger.database('Successfully connected to PostgreSQL database');
  });

} catch (err) {
  console.error('Failed to create database pool:', err);
  process.exit(1); // Exit with error code
}

// Remove pool.connect() as it's not needed here
// The pool will automatically connect when needed

export default pool;
