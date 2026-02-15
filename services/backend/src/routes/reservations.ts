import { Router, type Request, type Response } from 'express';
import { z } from 'zod';
import { Reservation } from '../models/Reservation.js';
import { logger } from '../utils/logger.js';

export const reservationsRouter: Router = Router();

// Validation schema for creating a booking
const createBookingSchema = z.object({
  carProviderId: z.number().int().positive(),
  vehicleType: z.string().min(1).max(50),
  pickupAddress: z.string().min(1).max(500),
  dropoffAddress: z.string().min(1).max(500),
  pickupTime: z.string().datetime(),
  dropoffTime: z.string().datetime().optional(),
  isTimeJob: z.boolean(),
  timeJobHours: z.number().positive().optional(),
  passengers: z.number().int().min(1).default(1),
  passengerName: z.string().min(1).max(255),
  passengerEmail: z.string().email().max(255).optional(),
  passengerPhone: z.string().max(50).optional(),
  notes: z.string().optional(),
  status: z.enum(['pending', 'confirmed', 'cancelled', 'completed']).optional(),
});

/**
 * GET /api/reservations
 * Returns all bookings
 */
reservationsRouter.get('/', async (_req: Request, res: Response) => {
  try {
    const bookings = await Reservation.getAll();
    res.json(bookings);
  } catch (error) {
    logger.error('Failed to fetch reservations:', error);
    res.status(500).json({ error: 'Failed to fetch reservations' });
  }
});

/**
 * POST /api/reservations
 * Creates a new booking
 */
reservationsRouter.post('/', async (req: Request, res: Response) => {
  try {
    const parsed = createBookingSchema.safeParse(req.body);
    
    if (!parsed.success) {
      res.status(400).json({ 
        error: 'Validation failed', 
        details: parsed.error.issues 
      });
      return;
    }

    const booking = await Reservation.create(parsed.data);
    res.status(201).json(booking);
  } catch (error) {
    logger.error('Failed to create reservation:', error);
    res.status(500).json({ error: 'Failed to create reservation' });
  }
});
