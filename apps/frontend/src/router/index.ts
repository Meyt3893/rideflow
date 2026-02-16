import { createRouter, createWebHistory } from 'vue-router';
import ReservationsView from '../views/ReservationsView.vue';
import NewReservationView from '../views/NewReservationView.vue';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'reservations',
      component: ReservationsView,
    },
    {
      path: '/new',
      name: 'new-reservation',
      component: NewReservationView,
    },
  ],
});

export default router;
