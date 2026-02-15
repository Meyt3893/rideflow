#!/bin/bash
# API Examples for Joint Work Reservations
# These curl commands can be used to test the API manually

API_URL="${API_URL:-http://localhost:3030}"

# ============================================
# GET /api/reservations - List all bookings
# ============================================

curl -s "$API_URL/api/reservations" | jq .

# ============================================
# POST /api/reservations - Create a new booking
# ============================================

# Example 1: Basic booking
curl -s -X POST "$API_URL/api/reservations" \
  -H "Content-Type: application/json" \
  -d '{
    "carProviderId": 1,
    "vehicleType": "sedan",
    "pickupAddress": "123 Main Street, New York, NY",
    "dropoffAddress": "456 Park Avenue, New York, NY",
    "pickupTime": "2026-02-20T10:00:00.000Z",
    "isTimeJob": false,
    "passengers": 2,
    "passengerName": "John Smith",
    "passengerEmail": "john.smith@example.com",
    "passengerPhone": "+1-555-123-4567"
  }' | jq .

# Example 2: Time job (hourly booking)
curl -s -X POST "$API_URL/api/reservations" \
  -H "Content-Type: application/json" \
  -d '{
    "carProviderId": 2,
    "vehicleType": "suv",
    "pickupAddress": "JFK Airport, Terminal 4",
    "dropoffAddress": "Multiple stops in Manhattan",
    "pickupTime": "2026-02-25T14:30:00.000Z",
    "isTimeJob": true,
    "timeJobHours": 4,
    "passengers": 4,
    "passengerName": "Sarah Johnson",
    "passengerEmail": "sarah.j@company.com",
    "notes": "Airport pickup with multiple stops for business meetings"
  }' | jq .

# Example 3: Luxury vehicle with notes
curl -s -X POST "$API_URL/api/reservations" \
  -H "Content-Type: application/json" \
  -d '{
    "carProviderId": 3,
    "vehicleType": "luxury",
    "pickupAddress": "The Plaza Hotel, 768 5th Ave",
    "dropoffAddress": "Lincoln Center, 10 Lincoln Center Plaza",
    "pickupTime": "2026-03-01T19:00:00.000Z",
    "dropoffTime": "2026-03-01T19:30:00.000Z",
    "isTimeJob": false,
    "passengers": 2,
    "passengerName": "Michael Chen",
    "passengerPhone": "+1-212-555-9999",
    "notes": "VIP client - evening gala event. Please arrive 10 minutes early.",
    "status": "confirmed"
  }' | jq .

# ============================================
# Health check
# ============================================

curl -s "$API_URL/health" | jq .
