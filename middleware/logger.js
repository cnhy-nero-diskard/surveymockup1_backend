// config/logger.js
import winston from 'winston';
import { EventEmitter } from 'events';

// Create an event emitter for real-time logging
export const logEmitter = new EventEmitter();

/**
 * Creates a Winston logger instance with the following configuration:
 * - Log level: 'info'
 * - Log format: Combines timestamp, colorization, and custom printf format
 * - Transports: Console and File (error.log for 'error' level)
 *
 * The logger emits log messages to any listeners via the 'logEmitter'.
 *
 * @constant {Object} logger - The Winston logger instance.
 */
const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-DD HH:mm:ss'
    }),
    winston.format.colorize(),
    winston.format.printf(({ timestamp, level, message }) => {
      const logMessage = `${timestamp} [${level}]: ${message}`;
      // Emit the log message to any listeners
      logEmitter.emit('log', logMessage);
      return logMessage;
    })
  ),
  transports: [
    new winston.transports.Console(),
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
  ],
});

export default logger;