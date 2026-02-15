<script setup lang="ts">
import type { Booking } from '@joint-work/shared';

defineProps<{
  bookings: Booking[];
  loading: boolean;
}>();

function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleString();
}
</script>

<template>
  <div class="table-container">
    <h2 style="padding: 16px 16px 0;">All Reservations</h2>
    
    <div v-if="loading" class="loading">Loading reservations...</div>
    
    <div v-else-if="bookings.length === 0" class="empty">
      No reservations found. Create one above!
    </div>
    
    <table v-else>
      <thead>
        <tr>
          <th>ID</th>
          <th>Passenger</th>
          <th>Vehicle</th>
          <th>Pickup</th>
          <th>Dropoff</th>
          <th>Pickup Time</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="booking in bookings" :key="booking.id">
          <td>{{ booking.id }}</td>
          <td>{{ booking.passengerName }}</td>
          <td>{{ booking.vehicleType }}</td>
          <td>{{ booking.pickupAddress }}</td>
          <td>{{ booking.dropoffAddress }}</td>
          <td>{{ formatDate(booking.pickupTime) }}</td>
          <td>
            <span :class="['status', `status-${booking.status}`]">
              {{ booking.status }}
            </span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
