<script setup lang="ts">
import { useRouter } from 'vue-router';
import type { Booking } from '@joint-work/shared';
import ReservationForm from '../components/ReservationForm.vue';

const router = useRouter();

function goBack() {
  router.push('/');
}

function handleCreated(_booking: Booking) {
  router.push('/');
}
</script>

<template>
  <div class="new-reservation-page">
    <div class="page-header">
      <button @click="goBack" class="btn-back">
        ← Back to Reservations
      </button>
      <h1>Book a Ride</h1>
      <p class="subtitle">Fill in the details below to reserve your car service</p>
    </div>
    
    <ReservationForm @created="handleCreated" />
  </div>
</template>

<style scoped>
.new-reservation-page {
  padding: 20px;
  max-width: 900px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 24px;
}

.page-header h1 {
  margin: 12px 0 8px 0;
  color: #1a1a1a;
}

.subtitle {
  color: #666;
  margin: 0;
}

.btn-back {
  background: none;
  border: none;
  color: #1976d2;
  cursor: pointer;
  padding: 0;
  font-size: 14px;
}

.btn-back:hover {
  text-decoration: underline;
}
</style>
