-- 1. procedimineto para eliminar un paquete completo con sus detalles, solo permite eliminar si no hay reservas asociadas
DELIMITER $$
CREATE PROCEDURE EliminarPaqueteCompleto(IN p_codigo_paquete VARCHAR(10))
BEGIN
    DECLARE num_reservas INT DEFAULT 0;
    DECLARE existe_paquete INT DEFAULT 0;
    -- si hay un error hacer rollback y mostrar el mensaje de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Verificar si el paquete existe
    SELECT COUNT(*) INTO existe_paquete
    FROM Paquete 
    WHERE cod = p_codigo_paquete;
    
    IF existe_paquete = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El paquete especificado no existe.';
    END IF;
    
    -- Verificar si hay reservas asociadas al paquete
    SELECT COUNT(*) INTO num_reservas
    FROM Rpaquete 
    WHERE paquete = p_codigo_paquete;
    
    IF num_reservas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el paquete porque tiene reservas asociadas.';
    END IF;
    
    -- eliminar
    START TRANSACTION;
		DELETE FROM DetallePaquete 
		WHERE paquete = p_codigo_paquete;
		
		DELETE FROM Paquete 
		WHERE cod = p_codigo_paquete;
    
    COMMIT;

END$$
DELIMITER ;

-- 2. PROCEDIMIENTO PARA ELIMINAR RESERVA COMPLETA
-- Elimina reserva con todos sus elementos relacionados
drop procedure if exists EliminarReservaCompleta;
DELIMITER $$
CREATE PROCEDURE EliminarReservaCompleta(IN p_numero_reserva INT)
BEGIN
    DECLARE existe_reserva INT DEFAULT 0;
    DECLARE tipo_reserva VARCHAR(50);
    
	-- si hay un error hacer rollback y mostrar el mensaje de error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Verificar si la reserva existe
    SELECT COUNT(*), tipo INTO existe_reserva, tipo_reserva
    FROM Reserva 
    WHERE num = p_numero_reserva
    GROUP BY tipo;
    
    IF existe_reserva = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La reserva especificada no existe.';
    END IF;
    
    START TRANSACTION;
    
    -- Eliminar incidencias asociadas si las hay
    DELETE iv FROM DetalleIncidenciaVuelo iv
    JOIN ParteIncidencia pi ON iv.parte = pi.cod
    WHERE pi.reserva = p_numero_reserva;
    
    DELETE die FROM DetalleIncidenciaEstancia die
    JOIN ParteIncidencia pi ON die.parte = pi.cod
    WHERE pi.reserva = p_numero_reserva;
    
    DELETE FROM ParteIncidencia WHERE reserva = p_numero_reserva;
    
    -- Eliminar vuelos asociados (solo para paquetes)
    IF tipo_reserva = 'paquete' THEN
        DELETE FROM Rvuelo WHERE reserva = p_numero_reserva;
    END IF;
    
    -- Eliminar contratos asociados
    DELETE FROM Contrato WHERE reserva = p_numero_reserva;
    
    -- Eliminar detalles de reserva
    DELETE FROM DetalleReserva WHERE reserva = p_numero_reserva;
    
    -- Si es reserva de paquete, eliminar de Rpaquete
    IF tipo_reserva = 'paquete' THEN
        DELETE FROM Rpaquete WHERE num = p_numero_reserva;
    END IF;
    
    -- Finalmente eliminar la reserva principal
    DELETE FROM Reserva WHERE num = p_numero_reserva;
    
    COMMIT;

END$$
DELIMITER ;

-- 3. eliminar parte de incidencia con todos sus detalles
drop procedure if exists EliminarParteIncidenciaCompleto;
DELIMITER $$
CREATE PROCEDURE EliminarParteIncidenciaCompleto(IN p_codigo_parte VARCHAR(10))
BEGIN
    DECLARE existe_parte INT DEFAULT 0;
    DECLARE reserva_asociada INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Verificar si el parte de incidencia existe
    SELECT COUNT(*) INTO existe_parte
    FROM ParteIncidencia 
    WHERE cod = p_codigo_parte
    GROUP BY reserva;
    
    IF existe_parte = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El parte de incidencia no existe.';
    END IF;
    
    START TRANSACTION;
    
    -- Eliminar detalles de incidencias de vuelo
    DELETE FROM DetalleIncidenciaVuelo 
    WHERE parte = p_codigo_parte;
    
    -- Eliminar detalles de incidencias de estancia
    DELETE FROM DetalleIncidenciaEstancia 
    WHERE parte = p_codigo_parte;
    
    -- Eliminar el parte de incidencia principal
    DELETE FROM ParteIncidencia 
    WHERE cod = p_codigo_parte;
    
    COMMIT;

END$$
DELIMITER ;


-- 4. calcular el beneficio de un paquete dado
DELIMITER //
CREATE FUNCTION calcular_beneficio_paquete(cod_paquete VARCHAR(10))
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE beneficio DECIMAL(10,2) DEFAULT 0;
    
    SELECT (p_venta - p_compra) INTO beneficio
    FROM Paquete
    WHERE cod = cod_paquete;
    
    -- Si no se encuentra el paquete, devuelve NULL
    IF beneficio IS NULL THEN
        RETURN NULL;
    END IF;
    
    RETURN beneficio;
END //
DELIMITER ;

-- 5. Obtener clientes activos de una sede dada
DELIMITER //
CREATE FUNCTION clientes_activos_sede(cod_sede VARCHAR(10))
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE num_clientes INT DEFAULT 0;
    
    SELECT COUNT(DISTINCT c.DNI) INTO num_clientes
    FROM Cliente c
    INNER JOIN Reserva r ON c.DNI = r.cliente
    INNER JOIN Empleado e ON r.empleado = e.DNI
    WHERE e.sede = cod_sede 
    AND c.activo = TRUE;
    
    RETURN num_clientes;
END //
DELIMITER ;

-- 6. Contar cuántas reservas ha hecho un cliente
DELIMITER //
CREATE FUNCTION contar_reservas_cliente(dni_cliente VARCHAR(20))
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE num_reservas INT DEFAULT 0;
    
    SELECT COUNT(*) INTO num_reservas
    FROM Reserva
    WHERE cliente = dni_cliente;
    
    RETURN num_reservas;
END //
DELIMITER ;

-- 7. Crear nueva reserva común con validaciones
drop procedure if exists CrearReservaComun;
DELIMITER $$
CREATE PROCEDURE CrearReservaComun(
    IN p_f_ini DATE,
    IN p_f_fin DATE,
    IN p_n_viajeros INT,
    IN p_menores2 BOOLEAN,
    IN p_observaciones VARCHAR(255),
    IN p_empleado VARCHAR(20),
    IN p_cliente VARCHAR(20)
)
BEGIN
    DECLARE cliente_activo BOOLEAN DEFAULT FALSE;
    DECLARE empleado_existe INT DEFAULT 0;
    DECLARE nuevo_num INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validaciones
    SELECT activo INTO cliente_activo FROM Cliente WHERE DNI = p_cliente;
    IF cliente_activo = FALSE OR cliente_activo IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente no existe o no está activo';
    END IF;

    SELECT COUNT(*) INTO empleado_existe FROM Empleado WHERE DNI = p_empleado AND f_baja IS NULL;
    IF empleado_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Empleado no existe o no está activo';
    END IF;

    IF p_f_ini >= p_f_fin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Fecha de inicio debe ser anterior a fecha fin';
    END IF;

    START TRANSACTION;

    -- Obtener nuevo número de reserva
    SELECT MAX(num) + 1 INTO nuevo_num FROM Reserva;

    -- Insertar nueva reserva
    INSERT INTO Reserva (num, f_reserva, f_ini, f_fin, n_viajeros, menores2, observaciones, empleado, cliente, tipo)
    VALUES (nuevo_num, CURDATE(), p_f_ini, p_f_fin, p_n_viajeros, p_menores2, p_observaciones, p_empleado, p_cliente, 'comun');

    COMMIT;
END$$
DELIMITER ;


-- 8. Añadir detalle a reserva calculando el numero y el precio
DELIMITER $$
CREATE PROCEDURE AnadirDetalleReserva(
    IN p_reserva INT,
    IN p_f_entrada DATE,
    IN p_f_salida DATE,
    IN p_hotel VARCHAR(10),
    IN p_tipo_habitacion VARCHAR(50),
    IN p_tipo_estancia VARCHAR(50),
    IN p_vivienda_turistica VARCHAR(10),
    IN p_extras VARCHAR(255),
    IN p_costo_ext DECIMAL(10,2)
)
BEGIN
    DECLARE precio_base DECIMAL(10,2) DEFAULT 0;
    DECLARE precio_total DECIMAL(10,2);
    DECLARE dias_estancia INT;
    DECLARE siguiente_num INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Calcular días de estancia
    SET dias_estancia = DATEDIFF(p_f_salida, p_f_entrada);
    
    -- Obtener siguiente número de detalle
    SELECT MAX(num) + 1 INTO siguiente_num 
    FROM DetalleReserva WHERE reserva = p_reserva;
    
    START TRANSACTION;
    
    -- Calcular precio según tipo de alojamiento
    IF p_hotel IS NOT NULL THEN
        SELECT precio INTO precio_base 
        FROM TipoHabitacion 
        WHERE hotel = p_hotel AND tipo = p_tipo_habitacion AND estancia = p_tipo_estancia;
        
        IF precio_base IS NULL THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de habitación no válido para el hotel';
        END IF;
    ELSEIF p_vivienda_turistica IS NOT NULL THEN
        SELECT precio INTO precio_base 
        FROM ViviendaTuristica 
        WHERE cod = p_vivienda_turistica;
    END IF;
    
    SET precio_total = (precio_base * dias_estancia) + p_costo_ext;
    
    INSERT INTO DetalleReserva (
        reserva, num, f_entrada, f_salida, confirmado, extras, 
        costo_ext, precio_tot, hotel, tipo_habitacion, tipo_estancia, vivienda_turistica
    ) VALUES (
        p_reserva, siguiente_num, p_f_entrada, p_f_salida, FALSE, p_extras,
        p_costo_ext, precio_total, p_hotel, p_tipo_habitacion, p_tipo_estancia, p_vivienda_turistica
    );
    
    COMMIT;
END$$
DELIMITER ;

-- 9. Crear cliente nuevo
DELIMITER $$
CREATE PROCEDURE CrearCliente(
    IN p_dni VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_tlfno VARCHAR(20),
    IN p_cp VARCHAR(5),
    IN p_observaciones VARCHAR(255)
)
BEGIN
    DECLARE cp_existe INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Validar CP existe
    SELECT COUNT(*) INTO cp_existe FROM CP WHERE cp = p_cp;
    IF cp_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código postal no válido';
    END IF;
    
    START TRANSACTION;
    
    INSERT INTO Cliente (DNI, nombre, apellidos, direccion, tlfno, cp, f_alta, f_baja, observaciones, activo)
    VALUES (p_dni, p_nombre, p_apellidos, p_direccion, p_tlfno, p_cp, CURDATE(), NULL, p_observaciones, TRUE);
    
    COMMIT;
END$$
DELIMITER ;


-- 10. Confirmar detalle de reserva
DELIMITER $$
CREATE PROCEDURE ConfirmarDetalleReserva(IN p_reserva INT, IN p_num_detalle INT)
BEGIN
    DECLARE detalle_existe INT DEFAULT 0;
    
    SELECT COUNT(*) INTO detalle_existe 
    FROM DetalleReserva 
    WHERE reserva = p_reserva AND num = p_num_detalle;
    
    IF detalle_existe = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Detalle de reserva no existe';
    END IF;
    
    UPDATE DetalleReserva 
    SET confirmado = TRUE 
    WHERE reserva = p_reserva AND num = p_num_detalle;
END$$
DELIMITER ;

-- 11. Calcular precio total de una reserva
DELIMITER //
CREATE FUNCTION calcular_precio_total_reserva(p_reserva INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE precio_total DECIMAL(10,2) DEFAULT 0;
    DECLARE existe_reserva INT;

    -- Verificar si la reserva existe
    SELECT COUNT(*) INTO existe_reserva FROM Reserva WHERE num = p_reserva;
    
    IF existe_reserva = 0 THEN
        RETURN NULL;
    END IF;
    
    -- Calcular el precio total
    SELECT SUM(precio_tot) INTO precio_total
    FROM DetalleReserva
    WHERE reserva = p_reserva;
    
    RETURN IFNULL(precio_total, 0);
END //
DELIMITER ;

-- 12. desactivar lo clientes que no hayan hecho una reserva en el ultimo año
DROP PROCEDURE IF EXISTS desactivar_clientes_inactivos;
DELIMITER $$
CREATE PROCEDURE desactivar_clientes_inactivos()
BEGIN
    DECLARE fin INT DEFAULT FALSE;
    DECLARE v_dni_cliente CHAR(9);
    
    DECLARE cursor_cliente CURSOR FOR SELECT DNI FROM Cliente;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

    OPEN cursor_cliente;

    leer_clientes: LOOP
        FETCH cursor_cliente INTO v_dni_cliente;

        IF fin THEN
            LEAVE leer_clientes;
        END IF;

        -- Si el cliente no ha reservado nada en el último año, lo desactivamos
        IF NOT EXISTS (
            SELECT 1 FROM Reserva r
            WHERE r.cliente = v_dni_cliente
              AND r.f_reserva >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
        ) THEN
            UPDATE Cliente SET activo = FALSE WHERE DNI = v_dni_cliente;
        END IF;
    END LOOP;

    CLOSE cursor_cliente;
END$$
DELIMITER ;
