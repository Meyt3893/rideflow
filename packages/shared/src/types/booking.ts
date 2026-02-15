/**
 * Booking status values
 */
export type BookingStatus = 'pending' | 'confirmed' | 'cancelled' | 'completed';

/**
 * Booking entity - represents a vehicle reservation
 */
export interface Booking {
  id?: number | undefined;
  carProviderId: number;
  vehicleType: string;
  pickupAddress: string;
  dropoffAddress: string;
  pickupTime: string;
  dropoffTime?: string | undefined;
  isTimeJob: boolean;
  timeJobHours?: number | undefined;
  passengers: number;
  passengerName: string;
  passengerEmail?: string | undefined;
  passengerPhone?: string | undefined;
  notes?: string | undefined;
  status: BookingStatus;
  created?: string | undefined;
  updated?: string | undefined;
}

/**
 * Payload for creating a new booking (excludes auto-generated fields)
 */
export interface CreateBookingPayload {
  carProviderId: number;
  vehicleType: string;
  pickupAddress: string;
  dropoffAddress: string;
  pickupTime: string;
  dropoffTime?: string | undefined;
  isTimeJob: boolean;
  timeJobHours?: number | undefined;
  passengers: number;
  passengerName: string;
  passengerEmail?: string | undefined;
  passengerPhone?: string | undefined;
  notes?: string | undefined;
  status?: BookingStatus | undefined;
}
