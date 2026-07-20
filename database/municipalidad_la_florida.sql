-- Base de datos utilizada por la API de usuarios.
CREATE DATABASE IF NOT EXISTS municipalidad_la_florida
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE municipalidad_la_florida;

CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

INSERT IGNORE INTO users (firstName, lastName, email) VALUES
('Lissette', 'Leon', 'lissette.leon@gmail.com'),
('Emilia', 'Gomez', 'emilia.gomez@hotmail.com'),
('Carlos', 'Lopez', 'carlos.lopez@outlook.com'),
('Tomas', 'Martinez', 'tomas.martinez@gmail.com'),
('Sofia', 'Sanchez', 'sofia.sanchez@hotmail.com'),
('Laura', 'Fernandez', 'laura.fernandez@outlook.com'),
('Diego', 'Torres', 'diego.torres@gmail.com'),
('Sofia', 'Ramirez', 'sofia.ramirez@hotmail.com'),
('Luis', 'Castro', 'luis.castro@outlook.com'),
('Elena', 'Mendoza', 'elena.mendoza@gmail.com');

SELECT * FROM users;
