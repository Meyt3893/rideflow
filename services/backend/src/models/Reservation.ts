import type { RowDataPacket, ResultSetHeader } from 'mysql2';
import { pool } from '../db.js';
import type { Booking, CreateBookingPayload } from '@joint-work/shared';

interface BookingRow extends RowDataPacket {
  id: number;
  car_provider_id: number;
  vehicle_type: string;
  pickup_address: string;
  dropoff_address: string;
  pickup_time: Date;
  dropoff_time: Date | null;
  is_time_job: number;
  time_job_hours: string | null;
  passengers: number;
  passenger_name: string;
  passenger_email: string | null;
  passenger_phone: string | null;
  notes: string | null;
  status: 'pending' | 'confirmed' | 'cancelled' | 'completed';
  created: Date;
  updated: Date;
}

/**
 * Convert ISO datetime string to MySQL datetime format
 */
function toMySQLDateTime(isoString: string): string {
  return isoString.replace('T', ' ').replace('Z', '').slice(0, 19);
}

function rowToBooking(row: BookingRow): Booking {
  return {
    id: row.id,
    carProviderId: row.car_provider_id,
    vehicleType: row.vehicle_type,
    pickupAddress: row.pickup_address,
    dropoffAddress: row.dropoff_address,
    pickupTime: row.pickup_time.toISOString(),
    dropoffTime: row.dropoff_time?.toISOString(),
    isTimeJob: Boolean(row.is_time_job),
    timeJobHours: row.time_job_hours ? parseFloat(row.time_job_hours) : undefined,
    passengers: row.passengers,
    passengerName: row.passenger_name,
    passengerEmail: row.passenger_email ?? undefined,
    passengerPhone: row.passenger_phone ?? undefined,
    notes: row.notes ?? undefined,
    status: row.status,
    created: row.created.toISOString(),
    updated: row.updated.toISOString(),
  };
}

export class Reservation {
  /**
   * Get all bookings
   */
  static async getAll(): Promise<Booking[]> {
    const [rows] = await pool.query<BookingRow[]>(
      "SELECT * FROM bookings WHERE status IN ('pending', 'confirmed') ORDER BY created DESC"
    );
    return rows.map(rowToBooking);
  }

  /**
   * Get a booking by ID
   */
  static async getById(id: number): Promise<Booking | null> {
    const [rows] = await pool.query<BookingRow[]>(
      'SELECT * FROM bookings WHERE id = ?',
      [id]
    );
    const row = rows[0];
    return row ? rowToBooking(row) : null;
  }

  /**
   * Create a new booking
   */
  static async create(payload: CreateBookingPayload): Promise<Booking> {
    const [result] = await pool.query<ResultSetHeader>(
      `INSERT INTO bookings (
        car_provider_id, vehicle_type, pickup_address, dropoff_address,
        pickup_time, dropoff_time, is_time_job, time_job_hours,
        passengers, passenger_name, passenger_email, passenger_phone,
        notes, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        payload.carProviderId,
        payload.vehicleType,
        payload.pickupAddress,
        payload.dropoffAddress,
        toMySQLDateTime(payload.pickupTime),
        payload.dropoffTime ? toMySQLDateTime(payload.dropoffTime) : null,
        payload.isTimeJob,
        payload.timeJobHours ?? null,
        payload.passengers,
        payload.passengerName,
        payload.passengerEmail ?? null,
        payload.passengerPhone ?? null,
        payload.notes ?? null,
        payload.status ?? 'pending',
      ]
    );

    const created = await Reservation.getById(result.insertId);
    if (!created) {
      throw new Error('Failed to retrieve created booking');
    }
    return created;
  }
}
