-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS art_commission_db;
USE art_commission_db;

-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS payments_table;
DROP TABLE IF EXISTS commission_table;
DROP TABLE IF EXISTS clients_table;

-- Create clients table
CREATE TABLE clients_table (
    client_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create commissions table
CREATE TABLE commission_table (
    commission_id VARCHAR(20) PRIMARY KEY,
    client_id VARCHAR(20) NOT NULL,
    description TEXT NOT NULL,
    start_date DATE NOT NULL,
    due_date DATE NOT NULL,
    artwork_status ENUM('pending', 'in_progress', 'complete') DEFAULT 'pending',
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('pending', 'paid') DEFAULT 'pending',
    final_delivery_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients_table(client_id) ON DELETE CASCADE
);

-- Create payments table
CREATE TABLE payments_table (
    payment_id VARCHAR(20) PRIMARY KEY,
    commission_id VARCHAR(20) NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    amount_remaining DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (commission_id) REFERENCES commission_table(commission_id) ON DELETE CASCADE
);

-- Insert some sample data
INSERT INTO clients_table (client_id, first_name, last_name, email, phone_number)
VALUES
('C001', 'John', 'Doe', 'john.doe@example.com', '555-123-4567'),
('C002', 'Jane', 'Smith', 'jane.smith@example.com', '555-987-6543'),
('C003', 'Robert', 'Johnson', 'robert.j@example.com', '555-456-7890');

INSERT INTO commission_table (commission_id, client_id, description, start_date, due_date, artwork_status, amount, payment_status)
VALUES
('COM001', 'C001', 'Digital portrait, full color', '2025-04-01', '2025-04-15', 'in_progress', 250.00, 'pending'),
('COM002', 'C002', 'Logo design for new business', '2025-04-05', '2025-04-20', 'pending', 150.00, 'pending'),
('COM003', 'C003', 'Book cover illustration', '2025-03-20', '2025-04-25', 'complete', 350.00, 'paid');


INSERT INTO payments_table (payment_id, commission_id, payment_date, amount_paid, amount_remaining, payment_method, payment_status)
VALUES
('PAY001', 'COM001', '2025-04-01', 100.00, 150.00, 'UPI', 'in_progress'),
('PAY002', 'COM003', '2025-03-25', 200.00, 150.00, 'Card', 'in_progress'),
('PAY003', 'COM003', '2025-04-05', 150.00, 0.00, 'Banking', 'completed');

select * FROM clients_table;
select * FROM commission_table;
select * FROM payments_table;