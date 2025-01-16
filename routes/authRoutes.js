// routes/authRoutes.js
import express from 'express';
import { login, registerAdmin,logout } from '../controllers/authController.js';
import { authenticate } from '../middleware/authMiddleware.js';

const router = express.Router();
router.post('/api/auth/login', login);
router.post('/api/auth/register-admin', registerAdmin);
router.post('/api/auth/logout', authenticate, logout); 
export default router;