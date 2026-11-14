CREATE DATABASE IF NOT EXISTS hotel_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hotel_management;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS newsletter;
DROP TABLE IF EXISTS inquiries;
DROP TABLE IF EXISTS restaurant_menu;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
 user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(190) NOT NULL UNIQUE,
 phone VARCHAR(30) NOT NULL,
 password VARCHAR(255) NOT NULL,
 role ENUM('customer','admin') NOT NULL DEFAULT 'customer',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_users_role(role)
) ENGINE=InnoDB;

CREATE TABLE rooms (
 room_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 room_name VARCHAR(120) NOT NULL,
 room_type ENUM('Deluxe Room','Premium Room','Executive Suite','Presidential Suite') NOT NULL,
 description TEXT NOT NULL,
 price DECIMAL(10,2) NOT NULL,
 capacity TINYINT UNSIGNED NOT NULL,
 bed_type VARCHAR(100) NOT NULL,
 image VARCHAR(500) NOT NULL,
 status ENUM('available','maintenance') NOT NULL DEFAULT 'available',
 INDEX idx_rooms_type_price(room_type,price),
 INDEX idx_rooms_status(status)
) ENGINE=InnoDB;

CREATE TABLE bookings (
 booking_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 booking_reference VARCHAR(24) NOT NULL UNIQUE,
 user_id INT UNSIGNED NULL,
 room_id INT UNSIGNED NOT NULL,
 guest_name VARCHAR(120) NOT NULL,
 guest_email VARCHAR(190) NOT NULL,
 guest_phone VARCHAR(30) NOT NULL,
 check_in DATE NOT NULL,
 check_out DATE NOT NULL,
 guests TINYINT UNSIGNED NOT NULL,
 total_amount DECIMAL(10,2) NOT NULL,
 special_requests TEXT NULL,
 status ENUM('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_bookings_user FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE SET NULL,
 CONSTRAINT fk_bookings_room FOREIGN KEY(room_id) REFERENCES rooms(room_id) ON DELETE RESTRICT,
 INDEX idx_booking_overlap(room_id,status,check_in,check_out),
 INDEX idx_booking_dates(check_in,check_out),
 INDEX idx_booking_guest(guest_email),
 INDEX idx_booking_created(created_at)
) ENGINE=InnoDB;

CREATE TABLE services (
 service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 service_name VARCHAR(140) NOT NULL,
 description TEXT NOT NULL,
 image VARCHAR(500) NOT NULL,
 status ENUM('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB;

CREATE TABLE restaurant_menu (
 item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 item_name VARCHAR(160) NOT NULL,
 category VARCHAR(70) NOT NULL,
 description TEXT NOT NULL,
 price DECIMAL(9,2) NOT NULL,
 image VARCHAR(500) NOT NULL,
 availability TINYINT(1) NOT NULL DEFAULT 1,
 INDEX idx_menu_category(category,availability)
) ENGINE=InnoDB;

CREATE TABLE inquiries (
 inquiry_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(190) NOT NULL,
 subject VARCHAR(180) NOT NULL,
 message TEXT NOT NULL,
 status ENUM('new','resolved') NOT NULL DEFAULT 'new',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_inquiry_status_created(status,created_at)
) ENGINE=InnoDB;

CREATE TABLE newsletter (
 subscriber_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 email VARCHAR(190) NOT NULL UNIQUE,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Demo password for all accounts is password (bcrypt hash from password_hash()).
INSERT INTO users(name,email,phone,password,role) VALUES
('Amara Sen','amara@example.com','+91 98765 10001','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','customer'),
('Rohan Mehta','rohan@example.com','+91 98765 10002','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','customer'),
('Mira Iyer','mira@example.com','+91 98765 10003','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','customer'),
('Dev Khanna','dev@example.com','+91 98765 10004','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','customer'),
('Anika Rao','anika@example.com','+91 98765 10005','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.','customer'),
('Hotel Administrator','admin@lumiere.example','+91 413 555 0142','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4o3Ro9llC/.og/at2uheWG/igi.','admin');

INSERT INTO rooms(room_name,room_type,description,price,capacity,bed_type,image,status) VALUES
('Garden Deluxe','Deluxe Room','A garden-facing retreat with a private veranda, soft linen and handcrafted details.','6800',2,'King bed','https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1200&q=82','available'),
('Courtyard Deluxe','Deluxe Room','A calm, light-filled room opening onto the old courtyard and its flowering frangipani.','7200',2,'Queen bed','https://images.unsplash.com/photo-1616594039964-ae9021a400a0?auto=format&fit=crop&w=1200&q=82','available'),
('Sea Breeze Premium','Premium Room','An airy upper-floor room with glimpses of the Bay of Bengal and a generous sitting area.','9400',3,'King bed + daybed','https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=1200&q=82','available'),
('Heritage Premium','Premium Room','High ceilings, restored timber and quiet views across Pondicherry’s historic quarter.','9800',3,'King bed','https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=82','available'),
('Lumière Executive Suite','Executive Suite','A separate sitting room and private balcony make room for both work and wandering.','14800',3,'King bed','https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?auto=format&fit=crop&w=1200&q=82','available'),
('Garden Executive Suite','Executive Suite','A tranquil suite with a garden terrace, generous bath and an invitation to linger.','15900',4,'King bed + sofa bed','https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=1200&q=82','available'),
('The Residence','Presidential Suite','Our most generous residence, with a dining salon, private plunge pool and attentive service.','32500',6,'King bed + twin room','https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1200&q=82','available'),
('Maison Lumière','Presidential Suite','A private home within the hotel, made for families and celebrations by the sea.','38900',6,'Two king bedrooms','https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=82','available');

INSERT INTO services(service_name,description,image,status) VALUES
('Garden swimming pool','A quiet freshwater pool tucked among tropical planting, open from first light until dusk.','https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1000&q=80','active'),
('Spa & wellness','Restorative treatments draw on local botanicals and the unhurried pace of the coast.','https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1000&q=80','active'),
('Fitness studio','A considered collection of equipment and movement classes, available throughout the day.','https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1000&q=80','active'),
('Airport transportation','A private car can be arranged for a smooth arrival from Chennai or Puducherry airport.','https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=1000&q=80','active'),
('Room service','A thoughtful selection from our kitchen, delivered to your room from morning to late evening.','https://images.unsplash.com/photo-1544148103-0773bf10d330?auto=format&fit=crop&w=1000&q=80','active'),
('Gatherings & meetings','An intimate salon and considered catering for conversations worth bringing people together for.','https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=1000&q=80','active');

INSERT INTO restaurant_menu(item_name,category,description,price,image,availability) VALUES
('Pondicherry fruit & yoghurt','Breakfast','Seasonal fruit, house-set yoghurt, toasted coconut and honey.','420','https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?auto=format&fit=crop&w=700&q=78',1),
('Brioche pain perdu','Breakfast','Caramelised brioche, orchard fruit and a little cultured cream.','520','https://images.unsplash.com/photo-1484723091739-30a097e8f929?auto=format&fit=crop&w=700&q=78',1),
('Market tomato salad','Starters','Heirloom tomatoes, basil, local olive oil and sea salt.','580','https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=700&q=78',1),
('Prawn & coconut broth','Starters','Coastal prawns, young coconut and a fragrant curry leaf broth.','720','https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?auto=format&fit=crop&w=700&q=78',1),
('Seared catch of the day','Mains','Today’s catch with garden greens, lemon butter and crisp potatoes.','1180','https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?auto=format&fit=crop&w=700&q=78',1),
('Slow braised lamb','Mains','Tender lamb, soft polenta and a deep rosemary jus.','1380','https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=700&q=78',1),
('Coconut vegetable curry','Mains','Market vegetables, turmeric rice and a warming coconut sauce.','820','https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=700&q=78',1),
('Garden herb linguine','Mains','Fresh pasta, garden herbs, parmesan and a bright lemon finish.','890','https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=700&q=78',1),
('Dark chocolate crémeux','Dessert','Silky chocolate, crisp praline and a pinch of sea salt.','490','https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=700&q=78',1),
('Cardamom crème brûlée','Dessert','A classic custard with fragrant cardamom and a delicate caramel top.','460','https://images.unsplash.com/photo-1470324161839-ce2bb6fa6bc3?auto=format&fit=crop&w=700&q=78',1),
('Seasonal fruit soda','Drinks','House-made fruit cordial, sparkling water and fresh garden mint.','320','https://images.unsplash.com/photo-1513558161293-cdaf765edfd7?auto=format&fit=crop&w=700&q=78',1),
('South Indian filter coffee','Drinks','Freshly drawn coffee, slow brewed and served the traditional way.','240','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=700&q=78',1);

INSERT INTO bookings(booking_reference,user_id,room_id,guest_name,guest_email,guest_phone,check_in,check_out,guests,total_amount,special_requests,status,created_at) VALUES
('LM-DEMO001',1,1,'Amara Sen','amara@example.com','+91 98765 10001','2026-12-12','2026-12-15',2,20400,'A quiet room, if possible.','confirmed',DATE_SUB(NOW(),INTERVAL 3 DAY)),
('LM-DEMO002',2,3,'Rohan Mehta','rohan@example.com','+91 98765 10002','2026-12-20','2026-12-23',2,28200,'','pending',DATE_SUB(NOW(),INTERVAL 2 DAY)),
('LM-DEMO003',3,5,'Mira Iyer','mira@example.com','+91 98765 10003','2027-01-05','2027-01-09',2,59200,'Celebrating an anniversary.','confirmed',DATE_SUB(NOW(),INTERVAL 8 DAY)),
('LM-DEMO004',4,2,'Dev Khanna','dev@example.com','+91 98765 10004','2026-11-20','2026-11-22',2,14400,'','cancelled',DATE_SUB(NOW(),INTERVAL 11 DAY)),
('LM-DEMO005',5,4,'Anika Rao','anika@example.com','+91 98765 10005','2027-02-14','2027-02-17',3,29400,'','confirmed',DATE_SUB(NOW(),INTERVAL 16 DAY)),
('LM-DEMO006',1,6,'Amara Sen','amara@example.com','+91 98765 10001','2027-03-02','2027-03-05',4,47700,'','pending',DATE_SUB(NOW(),INTERVAL 20 DAY)),
('LM-DEMO007',2,7,'Rohan Mehta','rohan@example.com','+91 98765 10002','2027-04-10','2027-04-14',5,130000,'Family trip.','confirmed',DATE_SUB(NOW(),INTERVAL 26 DAY)),
('LM-DEMO008',3,8,'Mira Iyer','mira@example.com','+91 98765 10003','2027-05-01','2027-05-04',4,116700,'','pending',DATE_SUB(NOW(),INTERVAL 35 DAY)),
('LM-DEMO009',4,3,'Dev Khanna','dev@example.com','+91 98765 10004','2026-12-28','2026-12-30',2,18800,'Late arrival.','confirmed',DATE_SUB(NOW(),INTERVAL 41 DAY)),
('LM-DEMO010',5,1,'Anika Rao','anika@example.com','+91 98765 10005','2027-06-11','2027-06-13',2,13600,'','cancelled',DATE_SUB(NOW(),INTERVAL 50 DAY));

INSERT INTO inquiries(name,email,subject,message,status,created_at) VALUES
('Leela Raman','leela@example.com','A celebration by the sea','We are hoping to organise a small anniversary dinner in February. Could you share a few details?','new',DATE_SUB(NOW(),INTERVAL 1 DAY)),
('Thomas & Claire','hello@example.com','A room with a garden','We are planning a quiet week in January and wondered which rooms open directly onto the garden.','new',DATE_SUB(NOW(),INTERVAL 3 DAY)),
('Nikhil Shah','nikhil@example.com','Airport arrival','Our flight arrives late in Chennai. Can a private transfer be arranged for the evening?','resolved',DATE_SUB(NOW(),INTERVAL 9 DAY));

INSERT INTO newsletter(email) VALUES ('notes@example.com'),('traveller@example.com');
