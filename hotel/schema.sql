CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;
CREATE TABLE users(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(80),email VARCHAR(120) UNIQUE,password VARCHAR(255),role ENUM('guest','admin') DEFAULT 'guest');
CREATE TABLE rooms(id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(80),type VARCHAR(30),price DECIMAL(8,2),capacity INT,description TEXT);
CREATE TABLE bookings(id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,room_id INT,check_in DATE,check_out DATE,guests INT,total DECIMAL(10,2),status ENUM('confirmed','cancelled','completed') DEFAULT 'confirmed',created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id),FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE);
INSERT INTO rooms(name,type,price,capacity,description) VALUES
('Cozy Single','Standard',1800,1,'Quiet room with work desk and city view.'),
('Deluxe Double','Deluxe',3200,2,'King bed, balcony, complimentary breakfast.'),
('Family Suite','Suite',5500,4,'Two bedrooms, lounge area and mini kitchen.'),
('Presidential Suite','Luxury',12000,3,'Top floor suite with private pool and butler service.');
