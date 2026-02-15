import { expect } from 'chai';
import sinon from 'sinon';
import { Reservation } from '../src/models/Reservation.js';
import type { Booking, CreateBookingPayload } from '@joint-work/shared';

describe('Reservation Model', () => {
  afterEach(() => {
    sinon.restore();
  });

  describe('create', () => {
    it('should create a booking with required fields', async () => {
      const mockBooking: Booking = {
        id: 1,
        carProviderId: 100,
        vehicleType: 'sedan',
        pickupAddress: '123 Main St',
        dropoffAddress: '456 Oak Ave',
        pickupTime: '2024-12-20T10:00:00.000Z',
        isTimeJob: false,
        passengers: 2,
        passengerName: 'John Doe',
        status: 'pending',
        created: '2024-12-15T12:00:00.000Z',
        updated: '2024-12-15T12:00:00.000Z',
      };

      // Stub the static methods
      const createStub = sinon.stub(Reservation, 'create').resolves(mockBooking);

      const payload: CreateBookingPayload = {
        carProviderId: 100,
        vehicleType: 'sedan',
        pickupAddress: '123 Main St',
        dropoffAddress: '456 Oak Ave',
        pickupTime: '2024-12-20T10:00:00.000Z',
        isTimeJob: false,
        passengers: 2,
        passengerName: 'John Doe',
      };

      const result = await Reservation.create(payload);

      expect(createStub.calledOnceWith(payload)).to.be.true;
      expect(result).to.deep.equal(mockBooking);
      expect(result.id).to.equal(1);
      expect(result.status).to.equal('pending');
    });
  });

  describe('getAll', () => {
    it('should return an array of bookings', async () => {
      const mockBookings: Booking[] = [
        {
          id: 1,
          carProviderId: 100,
          vehicleType: 'sedan',
          pickupAddress: '123 Main St',
          dropoffAddress: '456 Oak Ave',
          pickupTime: '2024-12-20T10:00:00.000Z',
          isTimeJob: false,
          passengers: 2,
          passengerName: 'John Doe',
          status: 'pending',
          created: '2024-12-15T12:00:00.000Z',
          updated: '2024-12-15T12:00:00.000Z',
        },
      ];

      const getAllStub = sinon.stub(Reservation, 'getAll').resolves(mockBookings);

      const result = await Reservation.getAll();

      expect(getAllStub.calledOnce).to.be.true;
      expect(result).to.be.an('array');
      expect(result).to.have.lengthOf(1);
      expect(result[0]?.passengerName).to.equal('John Doe');
    });
  });
});
