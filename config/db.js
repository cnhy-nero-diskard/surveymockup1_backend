// config/db.js
import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const requiredEnvVars = ['PG_USER', 'PG_HOST', 'PG_DATABASE', 'PG_PASSWORD', 'PG_PORT', 'JWT_SECRET'];
for (const envVar of requiredEnvVars) {
  if (!process.env[envVar]) {
    throw new Error(`Environment variable ${envVar} is not set`);
  }
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
const pool = new pg.Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASSWORD,
  port: process.env.PG_PORT,
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
  process.exit(-1); // Exit the process or handle the error appropriately
});

pool.connect();

export default pool;