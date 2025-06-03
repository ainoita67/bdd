
INSERT INTO CP (cp, poblacion, provincia) VALUES
('28001', 'Madrid', 'Madrid'),
('08001', 'Barcelona', 'Barcelona'),
('41001', 'Sevilla', 'Sevilla'),
('46001', 'Valencia', 'Valencia'),
('50001', 'Zaragoza', 'Zaragoza'),
('03001', 'Alicante', 'Alicante'),
('29001', 'Málaga', 'Málaga'),
('15001', 'A Coruña', 'A Coruña'),
('07001', 'Palma', 'Islas Baleares'),
('35001', 'Las Palmas de Gran Canaria', 'Las Palmas'),
('33001', 'Oviedo', 'Asturias'),
('26001', 'Logroño', 'La Rioja'),
('01001', 'Vitoria-Gasteiz', 'Álava'),
('20001', 'San Sebastián', 'Guipúzcoa'),
('48001', 'Bilbao', 'Vizcaya'),
('06001', 'Badajoz', 'Badajoz'),
('10001', 'Cáceres', 'Cáceres'),
('14001', 'Córdoba', 'Córdoba'),
('18001', 'Granada', 'Granada'),
('19001', 'Guadalajara', 'Guadalajara');

INSERT INTO Cliente (DNI, nombre, apellidos, direccion, tlfno, cp, f_alta, f_baja, observaciones, activo) VALUES
('12345678A', 'Laura', 'García Pérez', 'Calle Mayor 1, 2ºA', '612345678', '28001', '2023-01-15', NULL, 'Cliente frecuente', TRUE),
('23456789B', 'Carlos', 'Martínez López', 'Av. de América 45', '622345678', '08001', '2022-11-10', NULL, '', TRUE),
('34567890C', 'Marta', 'Sánchez Ruiz', 'Calle del Carmen 8', '632345678', '41001', '2024-03-01', NULL, '', TRUE),
('45678901D', 'David', 'Fernández Gómez', 'Calle Valencia 12', '642345678', '46001', '2021-07-20', '2024-05-30', 'Solicitó baja', FALSE),
('56789012E', 'Ana', 'Moreno Díaz', 'Calle de la Paz 33', '652345678', '50001', '2023-06-01', NULL, '', TRUE),
('67890123F', 'Javier', 'Jiménez Torres', 'Paseo del Prado 7', '662345678', '03001', '2022-04-12', NULL, '', TRUE),
('78901234G', 'Lucía', 'Romero Sánchez', 'Plaza Nueva 10', '672345678', '29001', '2023-09-17', NULL, 'Cliente VIP', TRUE),
('89012345H', 'Sergio', 'Navarro Cano', 'Calle Real 14', '682345678', '15001', '2020-10-05', NULL, '', TRUE),
('90123456I', 'Elena', 'Hernández Molina', 'Av. Galicia 22', '692345678', '07001', '2021-02-28', NULL, '', TRUE),
('01234567J', 'Pablo', 'Iglesias Marín', 'Calle León 19', '602345678', '35001', '2024-01-09', NULL, '', TRUE);

SET foreign_key_checks = 0;

INSERT INTO Sede (cod, nombre, direccion, cp, cif, iban, director) VALUES
('MAD01', 'Sede Central Madrid', 'Calle Alcalá 3', '28001', 'A12345678', 'ES912100041845020005', '11111111A'),
('BCN01', 'Sucursal Barcelona', 'Av. Diagonal 200', '08001', 'B23456789', 'ES452100041845020005', '22222222B'),
('SEV01', 'Sucursal Sevilla', 'Calle Betis 21', '41001', 'C34567890', 'ES332100041845020005', '33333333C'),
('VAL01', 'Sucursal Valencia', 'Av. del Cid 13', '46001', 'D45678901', 'ES552100041845020005', '44444444D'),
('ZAR01', 'Sucursal Zaragoza', 'Calle Zaragoza 5', '50001', 'E56789012', 'ES762100041845020005', '55555555E'),
('ALC01', 'Sucursal Alicante', 'Plaza del Sol 8', '03001', 'F67890123', 'ES872100041845020005', '66666666F'),
('MLG01', 'Sucursal Málaga', 'Av. del Mar 12', '29001', 'G78901234', 'ES982100041845020005', '77777777G'),
('COR01', 'Sucursal A Coruña', 'Calle Coruña 15', '15001', 'H89012345', 'ES002100041845020005', '88888888H'),
('PAL01', 'Sucursal Palma', 'Camino de Son Vida 33', '07001', 'I90123456', 'ES112100041845020005', '99999999I'),
('LPGC01', 'Sucursal Las Palmas', 'Calle Triana 27', '35001', 'J01234567', 'ES222100041845020001', '00000000J');

SET foreign_key_checks = 1;

INSERT INTO Empleado (DNI, nombre, apellidos, direccion, tlfno, cp, f_alta, f_baja, observaciones, sede) VALUES
('11111111A', 'Isabel', 'Domínguez Vera', 'Calle Alcalá 3', '611111111', '28001', '2022-05-15', NULL, '', 'MAD01'),
('22222222B', 'Alberto', 'Ruiz Navarro', 'Av. Diagonal 200', '622222222', '08001', '2020-12-01', NULL, '', 'BCN01'),
('33333333C', 'Raquel', 'Gómez León', 'Calle Betis 21', '633333333', '41001', '2023-04-20', NULL, '', 'SEV01'),
('44444444D', 'Manuel', 'Ortega Martín', 'Av. del Cid 13', '644444444', '46001', '2021-08-10', NULL, 'Encargado de atención al cliente', 'VAL01'),
('55555555E', 'Patricia', 'López Romero', 'Calle Zaragoza 5', '655555555', '50001', '2022-03-07', NULL, '', 'ZAR01'),
('66666666F', 'Álvaro', 'Santos Gil', 'Plaza del Sol 8', '666666666', '03001', '2021-01-25', '2023-12-31', 'Cambio de residencia', 'ALC01'),
('77777777G', 'Silvia', 'Vidal Castro', 'Av. del Mar 12', '677777777', '29001', '2020-06-01', NULL, '', 'MLG01'),
('88888888H', 'Fernando', 'Ibáñez Salas', 'Calle Coruña 15', '688888888', '15001', '2023-09-09', NULL, '', 'COR01'),
('99999999I', 'Beatriz', 'Navas Fuentes', 'Camino de Son Vida 33', '699999999', '07001', '2022-07-19', NULL, 'Recién incorporada', 'PAL01'),
('00000000J', 'Hugo', 'Rey Delgado', 'Calle Triana 27', '600000000', '35001', '2021-11-03', NULL, '', 'LPGC01');

INSERT INTO Categoria (cod, descripcion, tipo, iva) VALUES
-- Categorías de hoteles
('H1E', 'Hotel 1 estrella', 'hotel', 10.00),
('H2E', 'Hotel 2 estrellas', 'hotel', 10.00),
('H3E', 'Hotel 3 estrellas', 'hotel', 10.00),
('H4E', 'Hotel 4 estrellas', 'hotel', 10.00),
('H5E', 'Hotel 5 estrellas', 'hotel', 10.00),
('HGL', 'Hotel Gran Lujo', 'hotel', 10.00),
-- Categorías de viviendas turísticas
('VTB', 'Vivienda turística básica', 'vivienda turistica', 10.00),
('VT1C', 'Vivienda turística 1 llave', 'vivienda turistica', 10.00),
('VT2C', 'Vivienda turística 2 llaves', 'vivienda turistica', 10.00),
('VT3C', 'Vivienda turística 3 llaves', 'vivienda turistica', 10.00);

INSERT INTO Hotel (cod, nombre, f_alta, f_baja, direccion, cp, cif, tfno, n_habitaciones, categoria) VALUES
('HOT001', 'Hotel Sol Madrid', '2019-06-15', NULL, 'Calle Gran Vía 25', '28001', 'A11111111', '911111111', 120, 'H4E'),
('HOT002', 'Hotel Mar Azul', '2020-03-20', NULL, 'Paseo Marítimo 10', '29001', 'B22222222', '952222222', 85, 'H3E'),
('HOT003', 'Hotel Sierra Nevada', '2021-01-10', NULL, 'Av. Montaña 77', '18001', 'C33333333', '958333333', 60, 'H3E'),
('HOT004', 'Gran Hotel Palace', '2018-10-01', NULL, 'Plaza Mayor 1', '08001', 'D44444444', '933444444', 200, 'H5E'),
('HOT005', 'Hotel Bahía', '2022-07-05', NULL, 'Calle del Puerto 18', '41001', 'E55555555', '954555555', 70, 'H2E');

-- Hotel Sol Madrid (HOT001)
INSERT INTO TipoHabitacion (hotel, tipo, estancia, precio) VALUES
('HOT001', 'Individual', 'Solo alojamiento', 70.00),
('HOT001', 'Individual', 'Media pensión', 95.00),
('HOT001', 'Individual', 'Pensión completa', 115.00),
('HOT001', 'Doble', 'Solo alojamiento', 100.00),
('HOT001', 'Doble', 'Media pensión', 130.00),
('HOT001', 'Doble', 'Pensión completa', 160.00);

-- Hotel Mar Azul (HOT002)
INSERT INTO TipoHabitacion (hotel, tipo, estancia, precio) VALUES
('HOT002', 'Doble', 'Solo alojamiento', 85.00),
('HOT002', 'Doble', 'Media pensión', 110.00),
('HOT002', 'Doble', 'Pensión completa', 135.00),
('HOT002', 'Suite', 'Media pensión', 180.00),
('HOT002', 'Suite', 'Pensión completa', 210.00);

-- Hotel Sierra Nevada (HOT003)
INSERT INTO TipoHabitacion (hotel, tipo, estancia, precio) VALUES
('HOT003', 'Individual', 'Solo alojamiento', 60.00),
('HOT003', 'Individual', 'Media pensión', 80.00),
('HOT003', 'Doble', 'Solo alojamiento', 90.00),
('HOT003', 'Doble', 'Media pensión', 115.00);

-- Gran Hotel Palace (HOT004)
INSERT INTO TipoHabitacion (hotel, tipo, estancia, precio) VALUES
('HOT004', 'Doble', 'Media pensión', 200.00),
('HOT004', 'Doble', 'Pensión completa', 240.00),
('HOT004', 'Suite', 'Media pensión', 300.00),
('HOT004', 'Suite', 'Pensión completa', 350.00);

-- Hotel Bahía (HOT005)
INSERT INTO TipoHabitacion (hotel, tipo, estancia, precio) VALUES
('HOT005', 'Individual', 'Solo alojamiento', 50.00),
('HOT005', 'Individual', 'Media pensión', 75.00),
('HOT005', 'Doble', 'Solo alojamiento', 80.00),
('HOT005', 'Doble', 'Media pensión', 105.00),
('HOT005', 'Doble', 'Pensión completa', 125.00);

INSERT INTO Propietario (dni, nombre, email, tfno) VALUES
('12345678A', 'María López', 'maria.lopez@example.com', '600111111'),
('23456789B', 'Javier Ruiz', 'javier.ruiz@example.com', '600222222'),
('34567890C', 'Laura Gómez', 'laura.gomez@example.com', '600333333'),
('45678901D', 'Carlos Pérez', 'carlos.perez@example.com', '600444444'),
('56789012E', 'Ana Torres', 'ana.torres@example.com', '600555555');

INSERT INTO ViviendaTuristica (cod, nombre, plazas, precio, direccion, cp, propietario, categoria) VALUES
('VT001', 'Casa Sol', 4, 90.00, 'Calle Luna 12', '28001', '12345678A', 'VT2C'),
('VT002', 'Apartamento Playa', 2, 75.00, 'Av. del Mar 45', '29001', '23456789B', 'VT1C'),
('VT003', 'Villa Verde', 6, 150.00, 'Calle Jardín 7', '41001', '34567890C', 'VT3C'),
('VT004', 'Estudio Centro', 2, 60.00, 'Calle Mayor 10', '08001', '45678901D', 'VT1C'),
('VT005', 'Casa Rural Sierra', 8, 180.00, 'Camino del Bosque s/n', '18001', '56789012E', 'VTB');

INSERT INTO Mayorista (cod, nombre) VALUES
('MAY001', 'Viajes Mundo'),
('MAY002', 'Turismo Global'),
('MAY003', 'Aventuras y Más'),
('MAY004', 'Escapadas Exprés'),
('MAY005', 'Paquetes Premium');

INSERT INTO Paquete (cod, descripcion, p_compra, p_venta, f_ini, f_fin, mayorista) VALUES
('PAQ001', 'Escapada a la playa 7 noches', 500.00, 650.00, '2025-07-01', '2025-07-31', 'MAY001'),
('PAQ002', 'Circuito cultural por España 10 días', 1200.00, 1500.00, '2025-08-01', '2025-08-31', 'MAY002'),
('PAQ003', 'Aventura en la montaña 5 días', 400.00, 520.00, '2025-09-15', '2025-09-30', 'MAY003'),
('PAQ004', 'Fin de semana romántico', 250.00, 320.00, '2025-06-01', '2025-06-30', 'MAY004'),
('PAQ005', 'Paquete premium con spa y excursiones', 800.00, 1100.00, '2025-10-01', '2025-10-31', 'MAY005');

-- Detalles para PAQ001 (Escapada a la playa 7 noches)
INSERT INTO DetallePaquete (paquete, num, dias, ciudad, hotel, tipo_habitacion, tipo_estancia) VALUES
('PAQ001', 1, 3, 'Málaga', 'HOT002', 'Doble', 'Pensión completa'),
('PAQ001', 2, 4, 'Marbella', 'HOT005', 'Individual', 'Media pensión');

-- Detalles para PAQ002 (Circuito cultural por España 10 días)
INSERT INTO DetallePaquete (paquete, num, dias, ciudad, hotel, tipo_habitacion, tipo_estancia) VALUES
('PAQ002', 1, 4, 'Madrid', 'HOT001', 'Doble', 'Media pensión'),
('PAQ002', 2, 3, 'Barcelona', 'HOT004', 'Suite', 'Pensión completa'),
('PAQ002', 3, 3, 'Sevilla', 'HOT003', 'Individual', 'Solo alojamiento');

-- Detalles para PAQ003 (Aventura en la montaña 5 días)
INSERT INTO DetallePaquete (paquete, num, dias, ciudad, hotel, tipo_habitacion, tipo_estancia) VALUES
('PAQ003', 1, 5, 'Granada', 'HOT003', 'Doble', 'Media pensión');

-- Detalles para PAQ004 (Fin de semana romántico)
INSERT INTO DetallePaquete (paquete, num, dias, ciudad, hotel, tipo_habitacion, tipo_estancia) VALUES
('PAQ004', 1, 2, 'Valencia', 'HOT005', 'Doble', 'Pensión completa');

-- Detalles para PAQ005 (Paquete premium con spa y excursiones)
INSERT INTO DetallePaquete (paquete, num, dias, ciudad, hotel, tipo_habitacion, tipo_estancia) VALUES
('PAQ005', 1, 3, 'Madrid', 'HOT001', 'Individual', 'Pensión completa'),
('PAQ005', 2, 2, 'Barcelona', 'HOT004', 'Suite', 'Media pensión');

INSERT INTO Reserva (num, f_reserva, f_ini, f_fin, n_viajeros, menores2, observaciones, empleado, cliente, tipo) VALUES
(1, '2025-05-10', '2025-06-01', '2025-06-07', 2, FALSE, 'Viaje sin observaciones', '11111111A', '12345678A', 'comun'),
(2, '2025-05-15', '2025-07-10', '2025-07-17', 4, TRUE, 'Familia con dos niños', '22222222B', '23456789B', 'paquete'),
(3, '2025-05-20', '2025-08-05', '2025-08-15', 1, FALSE, NULL, '11111111A', '34567890C', 'paquete'),
(4, '2025-05-22', '2025-09-01', '2025-09-05', 3, FALSE, 'Viaje de trabajo', '33333333C', '01234567J', 'comun'),
(5, '2025-05-25', '2025-10-10', '2025-10-20', 2, TRUE, 'Escapada romántica', '44444444D', '56789012E', 'paquete'),
(6, '2025-05-30', '2025-06-15', '2025-06-22', 5, TRUE, 'Viaje en grupo', '11111111A', '12345678A', 'comun'),
(7, '2025-06-01', '2025-07-01', '2025-07-08', 2, FALSE, 'Primera reserva', '55555555E', '23456789B', 'paquete'),
(8, '2025-06-03', '2025-08-10', '2025-08-15', 4, TRUE, 'Vacaciones verano', '22222222B', '34567890C', 'comun'),
(9, '2025-06-05', '2025-09-10', '2025-09-15', 1, FALSE, NULL, '55555555E', '90123456I', 'paquete'),
(10, '2025-06-07', '2025-10-05', '2025-10-12', 3, FALSE, 'Viaje cultural', '44444444D', '56789012E', 'comun');


INSERT INTO Rpaquete (num, anticipo, coste_seguro, seguro, paquete) VALUES
(2, 200.00, 50.00, 'Seguro básico', 'PAQ001'),
(3, 500.00, 70.00, 'Seguro premium', 'PAQ002'),
(5, 300.00, 60.00, 'Seguro básico', 'PAQ004'),
(7, 150.00, 40.00, 'Seguro estándar', 'PAQ001'),
(9, 400.00, 80.00, 'Seguro premium', 'PAQ005');

-- Reserva 1 (común) - Hotel en Madrid
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (1, 1, '2025-06-01', '2025-06-07', TRUE, 'Desayuno incluido', 0.00, 840.00, 'HOT001', 'Doble', 'Solo alojamiento');

-- Reserva 4 (común) - Vivienda turística en Valencia
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, vivienda_turistica) 
VALUES (4, 1, '2025-09-01', '2025-09-05', TRUE, 'Limpieza final incluida', 0.00, 240.00, 'VT004');

-- Reserva 6 (común) - Hotel en Málaga
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (6, 1, '2025-06-15', '2025-06-22', TRUE, '2 habitaciones dobles', 0.00, 945.00, 'HOT002', 'Doble', 'Pensión completa');

-- Reserva 8 (común) - Vivienda turística en Sevilla
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, vivienda_turistica) 
VALUES (8, 1, '2025-08-10', '2025-08-15', TRUE, 'Cuna para bebé', 25.00, 775.00, 'VT003');

-- Reserva 10 (común) - Hotel en Barcelona
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (10, 1, '2025-10-05', '2025-10-12', TRUE, 'Suite con vistas', 100.00, 2100.00, 'HOT004', 'Suite', 'Media pensión');

-- Reserva 2 (paquete PAQ001) - Escapada a la playa 7 noches
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (2, 1, '2025-07-10', '2025-07-13', TRUE, 'Primera parte del paquete', 0.00, 405.00, 'HOT002', 'Doble', 'Pensión completa');

INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (2, 2, '2025-07-13', '2025-07-17', TRUE, 'Segunda parte del paquete', 0.00, 300.00, 'HOT005', 'Individual', 'Media pensión');

-- Reserva 3 (paquete PAQ002) - Circuito cultural por España 10 días
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (3, 1, '2025-08-05', '2025-08-09', TRUE, 'Etapa Madrid', 0.00, 520.00, 'HOT001', 'Doble', 'Media pensión');

INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (3, 2, '2025-08-09', '2025-08-12', TRUE, 'Etapa Barcelona', 0.00, 1050.00, 'HOT004', 'Suite', 'Pensión completa');

INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (3, 3, '2025-08-12', '2025-08-15', TRUE, 'Etapa Sevilla', 0.00, 180.00, 'HOT003', 'Individual', 'Solo alojamiento');

-- Reserva 5 (paquete PAQ004) - Fin de semana romántico
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (5, 1, '2025-10-10', '2025-10-12', TRUE, 'Paquete romántico', 50.00, 250.00, 'HOT005', 'Doble', 'Pensión completa');

-- Reserva 7 (paquete PAQ001) - Escapada a la playa 7 noches (mismo paquete que reserva 2)
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (7, 1, '2025-07-01', '2025-07-04', TRUE, 'Primera parte del paquete', 0.00, 405.00, 'HOT002', 'Doble', 'Pensión completa');

INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (7, 2, '2025-07-04', '2025-07-08', TRUE, 'Segunda parte del paquete', 0.00, 300.00, 'HOT005', 'Individual', 'Media pensión');

-- Reserva 9 (paquete PAQ005) - Paquete premium con spa y excursiones
INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (9, 1, '2025-09-10', '2025-09-13', TRUE, 'Etapa Madrid con spa', 100.00, 445.00, 'HOT001', 'Individual', 'Pensión completa');

INSERT INTO DetalleReserva (reserva, num, f_entrada, f_salida, confirmado, extras, costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia) 
VALUES (9, 2, '2025-09-13', '2025-09-15', TRUE, 'Etapa Barcelona premium', 150.00, 750.00, 'HOT004', 'Suite', 'Media pensión');

-- Contrato para Reserva 1 (común)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (1, 1, TRUE, 840.00, 420.00, '2025-05-10');

-- Contrato para Reserva 2 (paquete - tiene anticipo de 200.00)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (2, 2, TRUE, 705.00, 200.00, '2025-05-15');

-- Contrato para Reserva 3 (paquete - tiene anticipo de 500.00)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (3, 3, TRUE, 1750.00, 500.00, '2025-05-20');

-- Contrato para Reserva 4 (común)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (4, 4, FALSE, 240.00, 120.00, '2025-05-22');

-- Contrato para Reserva 5 (paquete - tiene anticipo de 300.00)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (5, 5, TRUE, 250.00, 300.00, '2025-05-25');

-- Contrato para Reserva 6 (común)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (6, 6, TRUE, 945.00, 472.50, '2025-05-30');

-- Contrato para Reserva 7 (paquete - tiene anticipo de 150.00)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (7, 7, FALSE, 705.00, 150.00, '2025-06-01');

-- Contrato para Reserva 8 (común)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (8, 8, TRUE, 775.00, 387.50, '2025-06-03');

-- Contrato para Reserva 9 (paquete - tiene anticipo de 400.00)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (9, 9, TRUE, 1195.00, 400.00, '2025-06-05');

-- Contrato para Reserva 10 (común)
INSERT INTO Contrato (cod, reserva, firmado_pagado, pago_contrato, pago_adelantado, fecha) 
VALUES (10, 10, FALSE, 2100.00, 1050.00, '2025-06-07');


-- Inserto los vuelos que realmente se usan en las reservas Rvuelo
INSERT INTO Vuelo (origen, destino, compania, precio, observaciones) VALUES
('Madrid', 'Málaga', 'Iberia', 120.00, 'Vuelo directo a Costa del Sol'),
('Málaga', 'Madrid', 'Vueling', 95.00, 'Vuelo de regreso con opción equipaje'),
('Barcelona', 'Madrid', 'Air Europa', 110.00, 'Vuelo puente aéreo frecuente'),
('Madrid', 'Barcelona', 'Iberia', 115.00, 'Vuelo directo a El Prat'),
('Barcelona', 'Sevilla', 'Vueling', 130.00, 'Vuelo con snacks incluidos'),
('Sevilla', 'Barcelona', 'Ryanair', 125.00, 'Vuelo económico sin escalas'),
('Madrid', 'Valencia', 'Iberia', 90.00, 'Vuelo rápido de 50 minutos'),
('Valencia', 'Madrid', 'Air Europa', 85.00, 'Vuelo vespertino directo'),
('Barcelona', 'Málaga', 'Vueling', 140.00, 'Vuelo matutino directo'),
('Málaga', 'Barcelona', 'Ryanair', 135.00, 'Vuelo con una sola maleta incluida'),
('Valencia', 'Madrid', 'Iberia', 95.00, 'Vuelo de conexión para paquetes'),
('Madrid', 'Barcelona', 'Air Europa', 105.00, 'Vuelo frecuente AVE disponible'),
('Barcelona', 'Valencia', 'Vueling', 100.00, 'Vuelo directo al aeropuerto de Manises');

-- Reserva 2 (PAQ001 - Escapada a la playa 7 noches: Málaga y Marbella)
INSERT INTO Rvuelo (origen, destino, compania, fecha_hora, reserva) VALUES
('Madrid', 'Málaga', 'Iberia', '2025-07-10 07:30:00', 2),
('Málaga', 'Madrid', 'Vueling', '2025-07-17 20:15:00', 2);

-- Reserva 3 (PAQ002 - Circuito cultural por España 10 días: Madrid, Barcelona, Sevilla)
INSERT INTO Rvuelo (origen, destino, compania, fecha_hora, reserva) VALUES
('Barcelona', 'Madrid', 'Air Europa', '2025-08-05 09:00:00', 3),
('Madrid', 'Barcelona', 'Iberia', '2025-08-09 18:45:00', 3),
('Barcelona', 'Sevilla', 'Vueling', '2025-08-12 10:30:00', 3),
('Sevilla', 'Barcelona', 'Ryanair', '2025-08-15 16:20:00', 3);

-- Reserva 5 (PAQ004 - Fin de semana romántico: Valencia)
INSERT INTO Rvuelo (origen, destino, compania, fecha_hora, reserva) VALUES
('Madrid', 'Valencia', 'Iberia', '2025-10-10 08:00:00', 5),
('Valencia', 'Madrid', 'Air Europa', '2025-10-12 21:30:00', 5);

-- Reserva 7 (PAQ001 - Escapada a la playa 7 noches: Málaga y Marbella)
INSERT INTO Rvuelo (origen, destino, compania, fecha_hora, reserva) VALUES
('Barcelona', 'Málaga', 'Vueling', '2025-07-01 06:45:00', 7),
('Málaga', 'Barcelona', 'Ryanair', '2025-07-08 19:15:00', 7);

-- Reserva 9 (PAQ005 - Paquete premium con spa y excursiones: Madrid y Barcelona)
INSERT INTO Rvuelo (origen, destino, compania, fecha_hora, reserva) VALUES
('Valencia', 'Madrid', 'Iberia', '2025-09-10 07:15:00', 9),
('Madrid', 'Barcelona', 'Air Europa', '2025-09-13 14:30:00', 9),
('Barcelona', 'Valencia', 'Vueling', '2025-09-15 17:45:00', 9);

INSERT INTO ParteIncidencia (cod, reserva) VALUES
('INC2025001', 2),
('INC2025002', 3),
('INC2025003', 5),
('INC2025004', 7),
('INC2025005', 9);

-- Incidencia 1: Retraso en vuelo de la Reserva 2
INSERT INTO DetalleIncidenciaVuelo (parte, num, origen, destino, compania, reserva, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025001', 1, 'Madrid', 'Málaga', 'Iberia', 2, 'Vuelo retrasado 3 horas por problemas técnicos', TRUE, TRUE, TRUE);

-- Incidencia 2: Cambio de aeropuerto en Reserva 3
INSERT INTO DetalleIncidenciaVuelo (parte, num, origen, destino, compania, reserva, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025002', 1, 'Barcelona', 'Madrid', 'Air Europa', 3, 'Vuelo desviado al aeropuerto de Barajas T4 sin asistencia en conexión', TRUE, FALSE, FALSE);

-- Incidencia 3: Equipaje perdido en Reserva 5
INSERT INTO DetalleIncidenciaVuelo (parte, num, origen, destino, compania, reserva, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025003', 1, 'Madrid', 'Valencia', 'Iberia', 5, 'Equipaje del cliente no llegó en el vuelo', TRUE, TRUE, FALSE);

-- Incidencia 4: Cancelación de vuelo en Reserva 7
INSERT INTO DetalleIncidenciaVuelo (parte, num, origen, destino, compania, reserva, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025004', 1, 'Barcelona', 'Málaga', 'Vueling', 7, 'Vuelo cancelado por huelga de tripulación', TRUE, TRUE, TRUE);

-- Incidencia 5: Sobreventa en Reserva 9
INSERT INTO DetalleIncidenciaVuelo (parte, num, origen, destino, compania, reserva, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025005', 1, 'Valencia', 'Madrid', 'Iberia', 9, 'Cliente afectado por sobreventa, reubicado en vuelo posterior', TRUE, TRUE, FALSE);

-- Incidencia 1: Problema con habitación en Reserva 2
INSERT INTO DetalleIncidenciaEstancia (parte, num, reserva, detalle, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025001', 1, 2, 1, 'Habitación no estaba limpia al llegar', TRUE, TRUE, TRUE),
('INC2025001', 2, 2, 1, 'Aire acondicionado no funcionaba correctamente', TRUE, TRUE, TRUE);

-- Incidencia 2: Cambio de hotel en Reserva 3
INSERT INTO DetalleIncidenciaEstancia (parte, num, reserva, detalle, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025002', 1, 3, 2, 'Hotel overbooked, cliente reubicado en hotel de categoría similar', TRUE, TRUE, FALSE);

-- Incidencia 3: Problema con servicios en Reserva 5
INSERT INTO DetalleIncidenciaEstancia (parte, num, reserva, detalle, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025003', 1, 5, 1, 'Servicio de spa no disponible durante la estancia', TRUE, FALSE, FALSE);

-- Incidencia 4: Problema con la reserva en Reserva 7
INSERT INTO DetalleIncidenciaEstancia (parte, num, reserva, detalle, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025004', 1, 7, 1, 'Tipo de habitación no coincidía con lo reservado', TRUE, TRUE, TRUE);

-- Incidencia 5: Problema con servicios premium en Reserva 9
INSERT INTO DetalleIncidenciaEstancia (parte, num, reserva, detalle, descripcion, transmitida, resuelta, cerrada) VALUES
('INC2025005', 1, 9, 2, 'Excursión incluida en paquete premium fue cancelada', TRUE, FALSE, FALSE);