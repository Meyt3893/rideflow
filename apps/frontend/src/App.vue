<script setup lang="ts">
import { ref, onMounted } from 'vue';
import type { Booking } from '@joint-work/shared';
import ReservationList from './components/ReservationList.vue';

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
  <div class="container">
    <h1>Reservations</h1>
    
    <!-- TODO: Add ReservationForm component here -->
    
    <div v-if="error" class="error">{{ error }}</div>
    
    <ReservationList 
      :bookings="bookings" 
      :loading="loading" 
    />
  </div>
</template>
