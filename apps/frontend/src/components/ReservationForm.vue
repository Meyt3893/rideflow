<script setup lang="ts">
import { ref } from 'vue';
import type { Booking, CreateBookingPayload } from '@joint-work/shared';

const emit = defineEmits<{
  created: [booking: Booking];
}>();

const submitting = ref(false);
const error = ref<string | null>(null);
const success = ref(false);

// Form fields
const carProviderId = ref(1);
const vehicleType = ref('sedan');
const pickupAddress = ref('');
const dropoffAddress = ref('');
const pickupTime = ref('');
const dropoffTime = ref('');
const isTimeJob = ref(false);
const timeJobHours = ref<number | undefined>(undefined);
const passengers = ref(1);
const passengerName = ref('');
const passengerEmail = ref('');
const passengerPhone = ref('');
const notes = ref('');

function resetForm() {
  carProviderId.value = 1;
  vehicleType.value = 'sedan';
  pickupAddress.value = '';
  dropoffAddress.value = '';
  pickupTime.value = '';
  dropoffTime.value = '';
  isTimeJob.value = false;
  timeJobHours.value = undefined;
  passengers.value = 1;
  passengerName.value = '';
  passengerEmail.value = '';
  passengerPhone.value = '';
  notes.value = '';
}

async function handleSubmit() {
  submitting.value = true;
  error.value = null;
  success.value = false;

  const payload: CreateBookingPayload = {
    carProviderId: carProviderId.value,
    vehicleType: vehicleType.value,
    pickupAddress: pickupAddress.value,
    dropoffAddress: dropoffAddress.value,
    pickupTime: pickupTime.value ? new Date(pickupTime.value).toISOString() : '',
    dropoffTime: dropoffTime.value ? new Date(dropoffTime.value).toISOString() : undefined,
    isTimeJob: isTimeJob.value,
    timeJobHours: isTimeJob.value ? timeJobHours.value : undefined,
    passengers: passengers.value,
    passengerName: passengerName.value,
    passengerEmail: passengerEmail.value || undefined,
    passengerPhone: passengerPhone.value || undefined,
    notes: notes.value || undefined,
  };

  try {
    const response = await fetch('/api/reservations', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
    });

    const data = await response.json();
    
    if (data.id) {
      emit('created', data);
      success.value = true;
      resetForm();

      setTimeout(() => {
        success.value = false;
      }, 3000);
    }
  } catch (e) {
    error.value = e instanceof Error ? e.message : 'An error occurred';
  } finally {
    submitting.value = false;
  }
}
</script>

<template>
  <div class="form">
    <h2>Create Reservation</h2>

    <div v-if="error" class="error">{{ error }}</div>
    <div v-if="success" class="success">Reservation created successfully!</div>

    <form @submit.prevent="handleSubmit">
      <div class="form-row">
        <div class="form-group">
          <label for="passengerName">Passenger Name *</label>
          <input
            id="passengerName"
            v-model="passengerName"
            type="text"
          />
        </div>
        <div class="form-group">
          <label for="passengerEmail">Email</label>
          <input
            id="passengerEmail"
            v-model="passengerEmail"
            type="email"
          />
        </div>
        <div class="form-group">
          <label for="passengerPhone">Phone</label>
          <input
            id="passengerPhone"
            v-model="passengerPhone"
            type="tel"
          />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="vehicleType">Vehicle Type</label>
          <select id="vehicleType" v-model="vehicleType">
            <option value="sedan">Sedan</option>
            <option value="suv">SUV</option>
            <option value="van">Van</option>
            <option value="luxury">Luxury</option>
          </select>
        </div>
        <div class="form-group">
          <label for="passengers">Passengers</label>
          <input
            id="passengers"
            v-model.number="passengers"
            type="number"
            min="1"
            max="20"
          />
        </div>
        <div class="form-group">
          <label for="carProviderId">Provider ID</label>
          <input
            id="carProviderId"
            v-model.number="carProviderId"
            type="number"
            min="1"
          />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="pickupAddress">Pickup Address *</label>
          <input
            id="pickupAddress"
            v-model="pickupAddress"
            type="text"
          />
        </div>
        <div class="form-group">
          <label for="dropoffAddress">Dropoff Address *</label>
          <input
            id="dropoffAddress"
            v-model="dropoffAddress"
            type="text"
          />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label for="pickupTime">Pickup Time *</label>
          <input
            id="pickupTime"
            v-model="pickupTime"
            type="datetime-local"
          />
        </div>
        <div class="form-group">
          <label for="dropoffTime">Dropoff Time</label>
          <input
            id="dropoffTime"
            v-model="dropoffTime"
            type="datetime-local"
          />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group checkbox-group">
          <input
            id="isTimeJob"
            v-model="isTimeJob"
            type="checkbox"
          />
          <label for="isTimeJob">Time Job (Hourly)</label>
        </div>
        <div v-if="isTimeJob" class="form-group">
          <label for="timeJobHours">Hours</label>
          <input
            id="timeJobHours"
            v-model.number="timeJobHours"
            type="number"
            min="1"
            step="0.5"
          />
        </div>
      </div>

      <div class="form-row">
        <div class="form-group" style="grid-column: 1 / -1;">
          <label for="notes">Notes</label>
          <textarea
            id="notes"
            v-model="notes"
            rows="3"
          ></textarea>
        </div>
      </div>

      <button type="submit" :disabled="submitting">
        {{ submitting ? 'Creating...' : 'Create Reservation' }}
      </button>
    </form>
  </div>
</template>
