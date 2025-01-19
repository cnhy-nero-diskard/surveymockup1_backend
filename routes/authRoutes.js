// routes/authRoutes.js
import express from 'express';
import { login, registerAdmin, logout } from '../controllers/authController.js';
import { authenticate } from '../middleware/authMiddleware.js';
import { verifyHMAC } from '../middleware/hmacMiddleware.js'; // Import HMAC middleware

const router = express.Router();

router.post('/api/auth/login', login);
router.post('/api/auth/register-admin', verifyHMAC, registerAdmin); // Apply HMAC middleware
router.post('/api/auth/logout', authenticate, logout);

export default router;