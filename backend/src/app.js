import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
// import userRoutes from './routes/userRoutes.js';

dotenv.config();
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Default route
app.get('/', (req, res) => {
  res.send('Backend running well!!');
});

// Routes
// app.use('/api/users', userRoutes);

export default app;
