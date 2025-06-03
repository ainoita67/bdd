
-- IMPORTAR CLIENTES
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clientes_20250603.csv'
INTO TABLE Cliente
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(DNI, nombre, apellidos, direccion, tlfno, cp, @poblacion, @provincia, f_alta, observaciones, activo)
SET f_baja = NULL;

-- IMPORTAR HOTELES
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hoteles_20250603.csv'
INTO TABLE Hotel
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cod, nombre, f_alta, direccion, cp, @poblacion, @provincia, cif, tfno, n_habitaciones, categoria, @categoria_desc)
SET f_baja = NULL;

-- IMPORTAR VIVIENDAS TURÍSTICAS
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/viviendas_20250603.csv'
INTO TABLE ViviendaTuristica
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cod, nombre, plazas, precio, direccion, cp, propietario, @propietario_nombre, @email, @tfno, categoria, @categoria_desc);

-- IMPORTAR MAYORISTAS
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mayoristas_20250603.csv'
INTO TABLE Mayorista
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(cod, nombre, @num_paquetes_activos);

-- IMPORTAR RESERVAS
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reservas_20250603.csv'
INTO TABLE Reserva
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(num, f_reserva, f_ini, f_fin, n_viajeros, menores2, observaciones, empleado, cliente, tipo);
