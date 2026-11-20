-- RESTMAN5 - DATABASE & DEMO DATA
-- WARNING: Running this script deletes the existing restman5 database and all its data.
-- Demo passwords are stored in plaintext for coursework only. Never use in production.
-- Image paths are relative to the web application root (WebContent/).

DROP DATABASE IF EXISTS restman5;
CREATE DATABASE restman5 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman5;

-- ======================== TABLES ========================
CREATE TABLE tblRestaurant5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(30),
    email VARCHAR(120),
    description TEXT
);

CREATE TABLE tblMember5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(80) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(120),
    phone VARCHAR(30),
    restaurantId BIGINT,
    FOREIGN KEY (restaurantId) REFERENCES tblRestaurant5(id)
);

CREATE TABLE tblStaff5 (
    memberId BIGINT PRIMARY KEY,
    position VARCHAR(60) NOT NULL,
    FOREIGN KEY (memberId) REFERENCES tblMember5(id)
);

CREATE TABLE tblCustomer5 (
    memberId BIGINT PRIMARY KEY,
    FOREIGN KEY (memberId) REFERENCES tblMember5(id)
);

CREATE TABLE tblMembershipCard5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(40) NOT NULL UNIQUE,
    createDate DATETIME NOT NULL,
    status VARCHAR(40) NOT NULL,
    customerId BIGINT NOT NULL UNIQUE,
    pointsBalance INT NOT NULL DEFAULT 0,
    totalPointsEarned INT NOT NULL DEFAULT 0,
    totalPointsUsed INT NOT NULL DEFAULT 0,
    FOREIGN KEY (customerId) REFERENCES tblCustomer5(memberId)
);

CREATE TABLE tblTable5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    tableNumber INT NOT NULL,
    capacity INT NOT NULL,
    status VARCHAR(40) NOT NULL,
    `condition` VARCHAR(80),
    type VARCHAR(60),
    restaurantId BIGINT NOT NULL,
    FOREIGN KEY (restaurantId) REFERENCES tblRestaurant5(id),
    UNIQUE (restaurantId, tableNumber)
);

CREATE TABLE tblDish5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(160) NOT NULL,
    type VARCHAR(80) NOT NULL,
    basePrice DECIMAL(15,2) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    restaurantId BIGINT NOT NULL,
    FOREIGN KEY (restaurantId) REFERENCES tblRestaurant5(id)
);

CREATE TABLE tblSize5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    pricePercentage FLOAT NOT NULL
);

CREATE TABLE tblDishSize5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    dishId BIGINT NOT NULL,
    sizeId BIGINT NOT NULL,
    UNIQUE (dishId, sizeId),
    FOREIGN KEY (dishId) REFERENCES tblDish5(id),
    FOREIGN KEY (sizeId) REFERENCES tblSize5(id)
);

CREATE TABLE tblCombo5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(160) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    startDate DATETIME,
    endDate DATETIME,
    restaurantId BIGINT NOT NULL,
    FOREIGN KEY (restaurantId) REFERENCES tblRestaurant5(id)
);

CREATE TABLE tblComboDetail5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    comboId BIGINT NOT NULL,
    dishSizeId BIGINT NOT NULL,
    FOREIGN KEY (comboId) REFERENCES tblCombo5(id),
    FOREIGN KEY (dishSizeId) REFERENCES tblDishSize5(id)
);

CREATE TABLE tblSupplier5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(160) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(30),
    email VARCHAR(120),
    description TEXT
);

CREATE TABLE tblIngredient5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(160) NOT NULL,
    unit VARCHAR(50),
    description TEXT
);

CREATE TABLE tblIngredientReceipt5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    importTime DATETIME NOT NULL,
    staffId BIGINT NOT NULL,
    supplierId BIGINT NOT NULL,
    FOREIGN KEY (staffId) REFERENCES tblStaff5(memberId),
    FOREIGN KEY (supplierId) REFERENCES tblSupplier5(id)
);

CREATE TABLE tblIngredientReceiptDetail5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quantity DECIMAL(12,2) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    ingredientId BIGINT NOT NULL,
    receiptId BIGINT NOT NULL,
    FOREIGN KEY (ingredientId) REFERENCES tblIngredient5(id),
    FOREIGN KEY (receiptId) REFERENCES tblIngredientReceipt5(id)
);

CREATE TABLE tblReservation5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    arrivalTime DATETIME NOT NULL,
    bookingTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    note TEXT,
    status VARCHAR(40),
    confirmationTime DATETIME,
    reason TEXT,
    memberId BIGINT NOT NULL,
    FOREIGN KEY (memberId) REFERENCES tblCustomer5(memberId)
);

CREATE TABLE tblReservationDetail5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    reservationId BIGINT NOT NULL,
    tableId BIGINT NOT NULL,
    FOREIGN KEY (reservationId) REFERENCES tblReservation5(id),
    FOREIGN KEY (tableId) REFERENCES tblTable5(id)
);

CREATE TABLE tblOrder5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    orderTime DATETIME NOT NULL,
    status VARCHAR(40) NOT NULL
);

CREATE TABLE tblOnlineOrder5 (
    orderId BIGINT PRIMARY KEY,
    reservationId BIGINT NOT NULL,
    FOREIGN KEY (orderId) REFERENCES tblOrder5(id),
    FOREIGN KEY (reservationId) REFERENCES tblReservation5(id)
);

CREATE TABLE tblOrderTable5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    orderId BIGINT NOT NULL,
    tableId BIGINT NOT NULL,
    UNIQUE (orderId, tableId),
    FOREIGN KEY (orderId) REFERENCES tblOrder5(id),
    FOREIGN KEY (tableId) REFERENCES tblTable5(id)
);

CREATE TABLE tblDishOrder5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    dishSizeId BIGINT NOT NULL,
    orderId BIGINT NOT NULL,
    FOREIGN KEY (dishSizeId) REFERENCES tblDishSize5(id),
    FOREIGN KEY (orderId) REFERENCES tblOrder5(id)
);

CREATE TABLE tblComboOrder5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    quantity INT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    comboId BIGINT NOT NULL,
    orderId BIGINT NOT NULL,
    FOREIGN KEY (comboId) REFERENCES tblCombo5(id),
    FOREIGN KEY (orderId) REFERENCES tblOrder5(id)
);

CREATE TABLE tblBill5 (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    paymentTime DATETIME NOT NULL,
    orderId BIGINT NOT NULL UNIQUE,
    customerId BIGINT,
    staffId BIGINT NOT NULL,
    pointsUsed INT NOT NULL DEFAULT 0,
    pointsEarned INT NOT NULL DEFAULT 0,
    membershipCardId BIGINT,
    FOREIGN KEY (orderId) REFERENCES tblOrder5(id),
    FOREIGN KEY (customerId) REFERENCES tblCustomer5(memberId),
    FOREIGN KEY (staffId) REFERENCES tblStaff5(memberId),
    FOREIGN KEY (membershipCardId) REFERENCES tblMembershipCard5(id)
);

-- ======================== DEMO DATA ========================
INSERT INTO tblRestaurant5 VALUES
(1,'RestMan Demo','Hà Nội','0240000000','demo@restman.local','Nhà hàng mẫu');

INSERT INTO tblMember5 VALUES
(1,'manager','123456','Quản lý Nguyễn An','Hà Nội','manager@demo.local','0900000001',1),
(2,'staff','123456','Nhân viên Trần Bình','Hà Nội','staff@demo.local','0900000002',1),
(3,'customer','123456','Khách hàng Lê Chi','Hà Nội','customer@demo.local','0900000003',1),
(4,'guestmember','123456','Khách hàng Phạm Duy','Hà Nội','guest@demo.local','0900000004',1);

INSERT INTO tblStaff5 VALUES (1,'Manager'),(2,'SalesStaff');
INSERT INTO tblCustomer5 VALUES (3),(4);
INSERT INTO tblMembershipCard5 VALUES
(1,'TV0001','2026-01-01 09:00:00','Active',3,150,300,150);

INSERT INTO tblTable5 VALUES
(1,1,4,'Trống','Tốt','Thường',1),
(2,2,6,'Trống','Tốt','Thường',1),
(3,3,4,'Trống','Tốt','VIP',1),
(4,4,2,'Trống','Tốt','Thường',1);

-- 6 dishes: paths relative to WebContent/
INSERT INTO tblDish5 (id,name,type,basePrice,description,image,restaurantId) VALUES
(1,'Kimbap bò','Món chính',55000,'Kimbap cuộn bò, rau củ','assets/images/dishes/kimbap-bo.jpg',1),
(2,'Kimbap truyền thống','Món chính',45000,'Kimbap rau củ truyền thống','assets/images/dishes/kimbap-truyen-thong.jpg',1),
(3,'Kimbap cá ngừ','Món chính',52000,'Kimbap cá ngừ sốt mayonnaise','assets/images/dishes/kimbap-ca-ngu.jpg',1),
(4,'Tokbokki cay','Món chính',60000,'Bánh gạo cay Hàn Quốc','assets/images/dishes/tokbokki-cay.jpg',1),
(5,'Canh rong biển','Món canh',35000,'Canh rong biển thanh nhẹ','assets/images/dishes/canh-rong-bien.jpg',1),
(6,'Trà đào','Đồ uống',30000,'Trà đào mát lạnh','assets/images/dishes/tra-dao.jpg',1);

INSERT INTO tblSize5 VALUES (1,'S',100),(2,'M',120),(3,'L',150);
INSERT INTO tblDishSize5 VALUES
(1,1,1),(2,1,2),(3,1,3),(4,2,1),(5,2,2),(6,3,1),
(7,3,2),(8,4,1),(9,5,1),(10,6,1),(11,6,2);

-- 3 combos: PNG images
INSERT INTO tblCombo5 (id,name,price,description,image,startDate,endDate,restaurantId) VALUES
(1,'Combo Kimbap truyền thống',99000,'Kimbap truyền thống, canh rong biển, trà đào','assets/images/combos/combo-kimbap-truyen-thong.png','2026-01-01 00:00:00','2027-12-31 23:59:59',1),
(2,'Combo Kimbap bò đặc biệt',129000,'Kimbap bò, tokbokki và trà đào','assets/images/combos/combo-kimbap-bo.png','2026-01-01 00:00:00','2027-12-31 23:59:59',1),
(3,'Combo Kimbap cá ngừ',109000,'Kimbap cá ngừ, canh rong biển, trà đào','assets/images/combos/combo-kimbap-ca-ngu.png','2026-01-01 00:00:00','2027-12-31 23:59:59',1);

INSERT INTO tblComboDetail5 VALUES
(1,1,1,4),(2,1,1,9),(3,1,1,10),
(4,1,2,1),(5,1,2,8),(6,1,2,10),
(7,1,3,6),(8,1,3,9),(9,1,3,10);

INSERT INTO tblSupplier5 VALUES
(1,'Nhà cung cấp thực phẩm A','Hà Nội','0900000010','supplier@demo.local','Nguyên liệu Hàn Quốc');
INSERT INTO tblIngredient5 VALUES
(1,'Gạo','kg','Gạo làm kimbap'),
(2,'Rong biển','gói','Rong biển cuộn');
INSERT INTO tblIngredientReceipt5 VALUES
(1,'2026-11-01 08:00:00',2,1);
INSERT INTO tblIngredientReceiptDetail5 VALUES
(1,20,25000,1,1),(2,50,15000,2,1);

INSERT INTO tblReservation5 VALUES
(1,'2026-11-10 18:00:00','2026-11-09 10:00:00',4,'Gần cửa sổ','Confirmed','2026-11-09 11:00:00',NULL,3);
INSERT INTO tblReservationDetail5 VALUES (1,1,1);

INSERT INTO tblOrder5 VALUES
(1,'2026-11-10 18:10:00','Paid'),
(2,'2026-11-11 12:00:00','Paid'),
(3,'2026-11-12 19:00:00','Paid'),
(4,'2026-11-13 12:30:00','Paid'),
(5,'2026-11-14 18:40:00','Paid'),
(6,'2026-11-15 11:45:00','Paid'),
(7,'2026-11-16 19:20:00','Paid'),
(8,'2026-11-17 18:10:00','Paid');

INSERT INTO tblOnlineOrder5 VALUES (1,1);
INSERT INTO tblOrderTable5 VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,1),
(5,5,2),(6,6,3),(7,7,4),(8,8,1);

INSERT INTO tblDishOrder5 VALUES
(1,2,55000,1,1),(2,1,30000,10,1),
(3,1,45000,4,2),(4,2,60000,8,2),
(5,2,52000,6,3),(6,1,35000,9,3),
(7,1,66000,2,4),(8,2,45000,4,4),
(9,3,55000,1,5),(10,1,30000,10,5),
(11,1,52000,6,6),(12,2,35000,9,6),
(13,2,60000,8,7),(14,1,55000,1,7),
(15,1,45000,4,8),(16,2,30000,10,8);

INSERT INTO tblComboOrder5 VALUES
(1,1,99000,1,1),(2,1,129000,2,3),
(3,2,109000,3,5),(4,1,99000,1,7);

INSERT INTO tblBill5 VALUES
(1,'2026-11-10 19:05:00',1,3,2,20,10,1),
(2,'2026-11-11 13:10:00',2,NULL,2,0,8,NULL),
(3,'2026-11-12 20:10:00',3,3,2,0,12,1),
(4,'2026-11-13 13:30:00',4,NULL,2,0,6,NULL),
(5,'2026-11-14 19:45:00',5,3,2,30,15,1),
(6,'2026-11-15 12:45:00',6,NULL,2,0,6,NULL),
(7,'2026-11-16 20:25:00',7,3,2,0,12,1),
(8,'2026-11-17 19:00:00',8,NULL,2,0,5,NULL);
