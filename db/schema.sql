CREATE TABLE IF NOT EXISTS bookings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  car_provider_id INT NOT NULL,
  vehicle_type VARCHAR(50) NOT NULL,
  pickup_address VARCHAR(500) NOT NULL,
  dropoff_address VARCHAR(500) NOT NULL,
  pickup_time DATETIME NOT NULL,
  dropoff_time DATETIME NULL,
  is_time_job BOOLEAN NOT NULL DEFAULT FALSE,
  time_job_hours DECIMAL(4,2) NULL,
  passengers INT NOT NULL DEFAULT 1,
  passenger_name VARCHAR(255) NOT NULL,
  passenger_email VARCHAR(255) NULL,
  passenger_phone VARCHAR(50) NULL,
  notes TEXT NULL,
  status ENUM('pending', 'confirmed', 'cancelled', 'completed') NOT NULL DEFAULT 'pending',
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
