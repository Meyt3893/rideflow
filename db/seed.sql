-- Seed data for testing
-- Run this after schema.sql to populate the database with test data

-- Clear existing data (optional - comment out if you want to keep existing data)
-- TRUNCATE TABLE bookings;

-- Insert test bookings with various statuses
INSERT INTO bookings (car_provider_id, vehicle_type, pickup_address, dropoff_address, pickup_time, passengers, passenger_name, passenger_email, passenger_phone, status, is_time_job) VALUES

-- Pending rides (should appear)
(1, 'sedan', '123 Main Street, New York, NY', 'JFK Airport, Queens, NY', DATE_ADD(NOW(), INTERVAL 1 DAY), 2, 'John Smith', 'john.smith@email.com', '555-123-4567', 'pending', false),
(1, 'suv', '456 Oak Avenue, Brooklyn, NY', 'LaGuardia Airport, Queens, NY', DATE_ADD(NOW(), INTERVAL 2 DAY), 4, 'Sarah Johnson', 'sarah.j@email.com', '555-987-6543', 'pending', false),

-- Confirmed rides (should appear)
(2, 'luxury', '789 Park Avenue, Manhattan, NY', 'Newark Airport, NJ', DATE_ADD(NOW(), INTERVAL 3 DAY), 2, 'Michael Brown', 'mbrown@company.com', '555-456-7890', 'confirmed', false),
(1, 'van', '321 Broadway, Manhattan, NY', 'Times Square, NY', DATE_ADD(NOW(), INTERVAL 1 DAY), 8, 'Emily Davis', 'emily.d@email.com', '555-321-6549', 'confirmed', false),

-- Completed rides (SHOULD appear but currently HIDDEN - this is the bug!)
(1, 'sedan', '100 Wall Street, Manhattan, NY', '200 Fifth Avenue, NY', DATE_SUB(NOW(), INTERVAL 2 DAY), 1, 'Robert Wilson', 'rwilson@email.com', '555-111-2222', 'completed', false),
(2, 'suv', '50 Central Park West, NY', 'Grand Central Terminal, NY', DATE_SUB(NOW(), INTERVAL 5 DAY), 3, 'Jennifer Lee', 'jlee@email.com', '555-333-4444', 'completed', false),
(1, 'luxury', '888 Madison Avenue, NY', 'Brooklyn Bridge, NY', DATE_SUB(NOW(), INTERVAL 7 DAY), 2, 'David Miller', 'dmiller@email.com', '555-555-6666', 'completed', false),

-- Cancelled rides (SHOULD appear but currently HIDDEN - this is the bug!)
(1, 'sedan', '999 Lexington Avenue, NY', 'Statue of Liberty Ferry, NY', DATE_ADD(NOW(), INTERVAL 1 DAY), 2, 'Lisa Anderson', 'lisa.a@email.com', '555-777-8888', 'cancelled', false),
(2, 'van', '777 Columbus Avenue, NY', 'Yankee Stadium, Bronx, NY', DATE_ADD(NOW(), INTERVAL 4 DAY), 6, 'James Taylor', 'jtaylor@email.com', '555-999-0000', 'cancelled', false),

-- Deleted rides (should NEVER appear - this filter is correct)
(1, 'sedan', '111 Deleted Street, NY', 'Nowhere, NY', DATE_SUB(NOW(), INTERVAL 10 DAY), 1, 'Deleted User', 'deleted@email.com', '555-000-0000', 'deleted', false),
(1, 'suv', '222 Removed Avenue, NY', 'Gone, NY', DATE_SUB(NOW(), INTERVAL 15 DAY), 2, 'Another Deleted', 'removed@email.com', '555-000-1111', 'deleted', false);

-- Summary:
-- Total: 11 bookings
-- Pending: 2 (visible)
-- Confirmed: 2 (visible)  
-- Completed: 3 (HIDDEN - BUG!)
-- Cancelled: 2 (HIDDEN - BUG!)
-- Deleted: 2 (hidden - correct behavior)
--
-- Users will see only 4 rides but expect to see 9 (all except deleted)
