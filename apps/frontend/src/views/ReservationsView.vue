<script setup lang="ts">
import { ref, onMounted } from 'vue';
import type { Booking } from '@joint-work/shared';
import ReservationList from '../components/ReservationList.vue';

const bookings = ref<Booking[]>([]);
const loading = ref(true);
const error = ref<string | null>(null);

async function fetchBookings() {
  try {
    loading.value = true;
    error.value = null;
    const response = await fetch('/api/reservations');
    if (!response.ok) {
      throw new Error('Failed to fetch reservations');
    }
    bookings.value = await response.json();
  } catch (e) {
    error.value = e instanceof Error ? e.message : 'An error occurred';
  } finally {
    loading.value = false;
  }
}

onMounted(() => {
  fetchBookings();
});
</script>

<template>
  <div class="reservations-page">
    <div class="page-header">
      <h1>Your Rides</h1>
      <router-link to="/new" class="btn-new">
        + Book a Ride
      </router-link>
    </div>
    
    <div v-if="error" class="error">{{ error }}</div>
    
    <ReservationList 
      :bookings="bookings" 
      :loading="loading" 
    />
  </div>
</template>

<style scoped>
.reservations-page {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h1 {
  margin: 0;
}

.btn-new {
  display: inline-block;
  padding: 10px 20px;
  background-color: #4CAF50;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  font-weight: 500;
  transition: background-color 0.2s;
}

.btn-new:hover {
  background-color: #45a049;
}

.error {
  background-color: #ffebee;
  color: #c62828;
  padding: 12px;
  border-radius: 4px;
  margin-bottom: 16px;
}
</style>
