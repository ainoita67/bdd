-- exportar clientes
DROP PROCEDURE IF EXISTS exportar_clientes;
DELIMITER $$


CREATE PROCEDURE exportar_clientes()
BEGIN
    SET @file := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clientes_', DATE_FORMAT(CURDATE(), '%Y%m%d'), '.csv');

    SET @sql := CONCAT(
        'SELECT c.DNI, c.nombre, c.apellidos, c.direccion, c.tlfno, c.cp, cp.poblacion, cp.provincia, c.f_alta, c.observaciones, c.activo ',
        'FROM Cliente c ',
        'INNER JOIN CP cp ON c.cp = cp.cp ',
        'WHERE c.f_alta >= DATE_SUB(CURDATE(), INTERVAL 15 DAY) ',
        'AND c.activo = TRUE ',
        'INTO OUTFILE "', @file, '" ',
        'FIELDS TERMINATED BY ";" ',
        'ENCLOSED BY ''"'' ',
        'LINES TERMINATED BY "\\n"'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;


-- EXPORTAR RESERVAS 
DROP PROCEDURE IF EXISTS exportar_reservas;
DELIMITER $$

CREATE PROCEDURE exportar_reservas()
BEGIN
    SET @file := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reservas_', DATE_FORMAT(CURDATE(), '%Y%m%d'), '.csv');

    SET @sql := CONCAT(
        'SELECT r.num, r.f_reserva, r.f_ini, r.f_fin, r.n_viajeros, r.menores2, r.observaciones, r.empleado, r.cliente, r.tipo ',
        'FROM Reserva r ',
        'WHERE r.f_reserva >= DATE_SUB(CURDATE(), INTERVAL 15 DAY) ',
        'INTO OUTFILE "', @file, '" ',
        'FIELDS TERMINATED BY ";" ENCLOSED BY \'"\' LINES TERMINATED BY "\\n"'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;


-- EXPORTAR HOTELES
DROP PROCEDURE IF EXISTS exportar_hoteles;
DELIMITER $$

CREATE PROCEDURE exportar_hoteles()
BEGIN
    SET @file := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hoteles_', DATE_FORMAT(CURDATE(), '%Y%m%d'), '.csv');

    SET @sql := CONCAT(
        'SELECT h.cod, h.nombre, h.f_alta, h.direccion, h.cp, cp.poblacion, cp.provincia, h.cif, h.tfno, h.n_habitaciones, h.categoria, cat.descripcion AS categoria_desc ',
        'FROM Hotel h ',
        'INNER JOIN CP cp ON h.cp = cp.cp ',
        'INNER JOIN Categoria cat ON h.categoria = cat.cod ',
        'WHERE h.f_baja IS NULL ',
        'INTO OUTFILE "', @file, '" ',
        'FIELDS TERMINATED BY ";" ENCLOSED BY \'"\' LINES TERMINATED BY "\\n"'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- EXPORTAR VIVIENDAS TURÍSTICAS
DROP PROCEDURE IF EXISTS exportar_viviendas;
DELIMITER $$

CREATE PROCEDURE exportar_viviendas()
BEGIN
    SET @file := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/viviendas_', DATE_FORMAT(CURDATE(), '%Y%m%d'), '.csv');

    SET @sql := CONCAT(
        'SELECT vt.cod, vt.nombre, vt.plazas, vt.precio, vt.direccion, vt.cp, cp.poblacion, cp.provincia, vt.propietario, p.nombre AS propietario_nombre, p.email, p.tfno, vt.categoria, cat.descripcion AS categoria_desc ',
        'FROM ViviendaTuristica vt ',
        'INNER JOIN CP cp ON vt.cp = cp.cp ',
        'INNER JOIN Propietario p ON vt.propietario = p.dni ',
        'INNER JOIN Categoria cat ON vt.categoria = cat.cod ',
        'INTO OUTFILE "', @file, '" ',
        'FIELDS TERMINATED BY ";" ENCLOSED BY \'"\' LINES TERMINATED BY "\\n"'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;


-- EXPORTAR MAYORISTAS (desde oficina central)
DROP PROCEDURE IF EXISTS exportar_mayoristas;
DELIMITER $$

CREATE PROCEDURE exportar_mayoristas()
BEGIN
    SET @file := CONCAT('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mayoristas_', DATE_FORMAT(CURDATE(), '%Y%m%d'), '.csv');

    SET @sql := CONCAT(
        'SELECT m.cod, m.nombre, COUNT(p.cod) AS num_paquetes_activos ',
        'FROM Mayorista m ',
        'LEFT JOIN Paquete p ON m.cod = p.mayorista AND p.f_fin >= CURDATE() ',
        'GROUP BY m.cod, m.nombre ',
        'INTO OUTFILE "', @file, '" ',
        'FIELDS TERMINATED BY ";" ENCLOSED BY \'"\' LINES TERMINATED BY "\\n"'
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;
