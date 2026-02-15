import { describe, it, expect } from 'vitest';
import { mount } from '@vue/test-utils';
import ReservationList from '../ReservationList.vue';
import type { Booking } from '@joint-work/shared';

describe('ReservationList', () => {
  it('shows loading state when loading is true', () => {
    const wrapper = mount(ReservationList, {
      props: {
        bookings: [],
        loading: true,
      },
    });

    expect(wrapper.text()).toContain('Loading reservations...');
  });

  it('shows empty state when no bookings', () => {
    const wrapper = mount(ReservationList, {
      props: {
        bookings: [],
        loading: false,
      },
    });

    expect(wrapper.text()).toContain('No reservations found');
  });

  it('renders bookings in a table', () => {
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

    const wrapper = mount(ReservationList, {
      props: {
        bookings: mockBookings,
        loading: false,
      },
    });

    expect(wrapper.find('table').exists()).toBe(true);
    expect(wrapper.text()).toContain('John Doe');
    expect(wrapper.text()).toContain('sedan');
    expect(wrapper.text()).toContain('pending');
  });
});
