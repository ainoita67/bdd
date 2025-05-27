-- CP
INSERT INTO CP VALUES
('28001', 'Madrid', 'Madrid'),
('08001', 'Barcelona', 'Barcelona'),
('41001', 'Sevilla', 'Sevilla');

-- Cliente
INSERT INTO Cliente VALUES
('12345678A', 'Luis', 'Martínez López', 'Calle Mayor 10', '600123456', '28001', '2023-01-15', NULL, NULL, TRUE),
('23456789B', 'Ana', 'Gómez Pérez', 'Av. Diagonal 123', '600234567', '08001', '2023-03-01', NULL, NULL, TRUE),
('34567890C', 'Carlos', 'Ruiz Fernández', 'C/ Sierpes 20', '600345678', '41001', '2023-04-20', NULL, NULL, TRUE);

-- Empleado (se añade sede luego)
INSERT INTO Empleado VALUES
('11111111A', 'Marta', 'Jiménez', 'Calle Gran Vía 45', '600111111', '28001', '2022-10-01', NULL, NULL, 'S01'),
('22222222B', 'Raúl', 'Torres', 'Rambla Catalunya 12', '600222222', '08001', '2022-11-15', NULL, NULL, 'S02'),
('33333333C', 'Laura', 'Navas', 'C/ Betis 30', '600333333', '41001', '2022-12-01', NULL, NULL, 'S03');

-- Sede
INSERT INTO Sede VALUES
('S01', 'Oficina Central Madrid', 'Calle Alcalá 50', '28001', 'A12345678', '20770024003102575766', '11111111A'),
('S02', 'Sucursal Barcelona', 'Av. Meridiana 100', '08001', 'B87654321', '21000418401234567891', '22222222B'),
('S03', 'Sucursal Sevilla', 'Calle Feria 23', '41001', 'C45678912', '21000813610123456789', '33333333C');

-- Categoria
INSERT INTO Categoria VALUES
('C01', 'Hotel 4 estrellas', 'Hotel', 10.00),
('C02', 'Hotel 5 estrellas', 'Hotel', 21.00),
('C03', 'Apartamento Premium', 'Vivienda', 10.00);

-- Hotel
INSERT INTO Hotel VALUES
('H01', 'Hotel Central', '2022-01-01', NULL, 'Calle Sol 1', '28001', 'H12345678', '915123456', 100, 'C01'),
('H02', 'Hotel Mediterráneo', '2022-03-10', NULL, 'Paseo Marítimo 5', '08001', 'H87654321', '932654321', 80, 'C02'),
('H03', 'Hotel Guadalquivir', '2022-05-15', NULL, 'C/ Triana 12', '41001', 'H56789123', '954789123', 60, 'C01');

-- TipoHabitacion
INSERT INTO TipoHabitacion VALUES
('H01', 'Doble', 'Media pensión', 120.00),
('H02', 'Suite', 'Todo incluido', 250.00),
('H03', 'Individual', 'Solo alojamiento', 90.00);

-- Propietario
INSERT INTO Propietario VALUES
('44444444D', 'Javier Domínguez', 'javierd@example.com', '600444444'),
('55555555E', 'María López', 'marial@example.com', '600555555'),
('66666666F', 'Pedro Sánchez', 'pedros@example.com', '600666666');

-- ViviendaTuristica
INSERT INTO ViviendaTuristica VALUES
('VT01', 'Apartamento Centro', 4, 85.00, 'Calle Arenal 3', '28001', '44444444D', 'C03'),
('VT02', 'Ático Playa', 2, 120.00, 'Calle Marina 7', '08001', '55555555E', 'C03'),
('VT03', 'Casa Patio', 6, 110.00, 'Calle San Luis 22', '41001', '66666666F', 'C03');

-- Mayorista
INSERT INTO Mayorista VALUES
('M01', 'Viajes Global'),
('M02', 'Turismo Exprés'),
('M03', 'Aventura Total');

-- Paquete
INSERT INTO Paquete VALUES
('P01', 'Escapada Madrid 3 días', 200.00, 300.00, '2023-06-01', '2023-06-30', 'M01'),
('P02', 'Barcelona Deluxe', 400.00, 600.00, '2023-07-01', '2023-07-31', 'M02'),
('P03', 'Ruta Andaluza', 350.00, 500.00, '2023-08-01', '2023-08-15', 'M03');

-- DetallePaquete
INSERT INTO DetallePaquete VALUES
('P01', 1, 2, 'Madrid', 'H01', 'Doble', 'Media pensión'),
('P02', 1, 3, 'Barcelona', 'H02', 'Suite', 'Todo incluido'),
('P03', 1, 2, 'Sevilla', 'H03', 'Individual', 'Solo alojamiento');

-- Reserva
INSERT INTO Reserva VALUES
(1, '2024-05-01', '2024-06-01', '2024-06-04', 2, FALSE, NULL, '11111111A', '12345678A', 'comun'),
(2, '2024-05-10', '2024-07-01', '2024-07-04', 3, TRUE, NULL, '22222222B', '23456789B', 'paquete'),
(3, '2024-05-20', '2024-08-05', '2024-08-10', 4, FALSE, NULL, '33333333C', '34567890C', 'paquete');


-- Rpaquete
INSERT INTO Rpaquete VALUES
(2, 100.00, 20.00, 'Mapfre', 'P02'),
(3, 150.00, 30.00, 'Allianz', 'P03');

-- DetalleReserva
INSERT INTO DetalleReserva VALUES
(1, 1, '2024-06-01', '2024-06-04', TRUE, NULL, 20.00, 380.00, 'H01', 'Doble', 'Media pensión', NULL),
(2, 1, '2024-07-01', '2024-07-04', TRUE, NULL, 0.00, 600.00, 'H02', 'Suite', 'Todo incluido', NULL),
(3, 1, '2024-08-05', '2024-08-10', TRUE, NULL, 0.00, 500.00, 'H03', 'Individual', 'Solo alojamiento', NULL);


-- Contrato
INSERT INTO Contrato VALUES
(1, 1, TRUE, 380.00, 100.00, '2024-05-05'),
(2, 2, TRUE, 600.00, 100.00, '2024-05-12'),
(3, 3, FALSE, 500.00, 150.00, '2024-05-22');

-- Vuelo
INSERT INTO Vuelo VALUES
('Madrid', 'Barcelona', 'Iberia', 90.00, NULL),
('Sevilla', 'Madrid', 'Vueling', 80.00, NULL),
('Barcelona', 'Sevilla', 'AirEuropa', 95.00, NULL);

-- Rvuelo
INSERT INTO Rvuelo VALUES
('Madrid', 'Barcelona', 'Iberia', '2024-06-01 10:00:00', 2),
('Sevilla', 'Madrid', 'Vueling', '2024-08-05 09:30:00', 3),
('Barcelona', 'Sevilla', 'AirEuropa', '2024-07-01 08:00:00', 2);

-- ParteIncidencia
INSERT INTO ParteIncidencia VALUES
('PI01', 2),
('PI02', 3),
('PI03', 1);

-- DetalleIncidenciaVuelo
INSERT INTO DetalleIncidenciaVuelo VALUES
('PI01', 1, 'Madrid', 'Barcelona', 'Iberia', 2, 'Vuelo con retraso', TRUE, FALSE, FALSE),
('PI02', 1, 'Sevilla', 'Madrid', 'Vueling', 3, 'Pérdida de equipaje', TRUE, TRUE, TRUE),
('PI03', 1, 'Barcelona', 'Sevilla', 'AirEuropa', 2, 'Problema con asiento', FALSE, FALSE, FALSE);

-- DetalleIncidenciaEstancia
INSERT INTO DetalleIncidenciaEstancia VALUES
('PI03', 2, 1, 1, 'Problema con habitación', TRUE, TRUE, TRUE),
('PI01', 2, 2, 1, 'Ruido excesivo', FALSE, FALSE, FALSE),
('PI02', 2, 3, 1, 'Sin agua caliente', TRUE, TRUE, TRUE);

-- Mayorista
INSERT INTO Mayorista (cod, nombre) VALUES ('M001', 'GlobalViajes');

-- Paquete disponible
INSERT INTO Paquete values
('P04', 'Ruta Andaluza', 350.00, 500.00, '2023-08-01', '2026-08-15', 'M03');

INSERT INTO Reserva VALUES
(4, '2025-05-01', '2025-06-01', '2025-06-04', 2, FALSE, NULL, '11111111A', '12345678A', 'comun'),
(5, '2025-05-01', '2025-06-01', '2025-06-04', 2, FALSE, NULL, '11111111A', '12345678A', 'comun');

-- Contrato
INSERT INTO Contrato VALUES
(4, 4, TRUE, 380.00, 100.00, '2025-05-26'),
(5, 5, TRUE, 600.00, 100.00, '2025-05-28');
