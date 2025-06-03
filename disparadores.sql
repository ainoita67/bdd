-- controlar que un un detalle reserva sea de una reserva existente y solo coja tipos de habitaciones disponibles en el paquete que esta reservado en la reserva del paquete

DELIMITER $$

CREATE TRIGGER comprobar_tipo_habitacion_paquete
BEFORE INSERT ON DetalleReserva
FOR EACH ROW
BEGIN
  DECLARE tipo_reserva VARCHAR(50);
  DECLARE cod_paquete VARCHAR(10);
  DECLARE existe INT;
  DECLARE existeR INT;

  SELECT tipo INTO tipo_reserva
  FROM Reserva
  WHERE num = NEW.reserva;

  -- Solo se hace la comprovacion si es de tipo paquete
  IF tipo_reserva = 'paquete' THEN

    -- Obtener el paquete asociado de la tabla rpaquete
    SELECT paquete INTO cod_paquete
    FROM Rpaquete
    WHERE num = NEW.reserva;

    -- Verificar si el tipo de habitación está incluido en ese paquete
    SELECT COUNT(*) INTO existe
    FROM DetallePaquete
    WHERE paquete = cod_paquete
      AND hotel = NEW.hotel
      AND tipo_habitacion = NEW.tipo_habitacion
      AND tipo_estancia = NEW.tipo_estancia;

    -- Si no existe, lanzar error
    IF existe = 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'La habitación seleccionada no pertenece al paquete asociado en la reserva.';
    END IF;
  END IF;
END$$

DELIMITER ;

-- controlar que un un detalle de incidencia de estancia solo coja detalles de la reserva asociada al parte
DELIMITER $$

CREATE TRIGGER comprobar_detalle_reserva_incidencia
BEFORE INSERT ON DetalleIncidenciaEstancia
FOR EACH ROW
BEGIN
	DECLARE existe INT;

	SELECT COUNT(*) INTO existe
	FROM ParteIncidencia
	WHERE reserva = new.reserva AND cod = new.parte;

-- Si no existe, lanzar error
IF existe = 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'El detalle de reserva seleccionado no corresponde a la reserva registrada en el parte de esta incidencia.';
END IF;
END$$

DELIMITER ;

-- controlar que un detalle de incidencia de vuelo solo coja reservas de vuelos de la reserva asociada al parte
DELIMITER $$

CREATE TRIGGER comprobar_reserva_vuelo_incidencia
BEFORE INSERT ON DetalleIncidenciaVuelo
FOR EACH ROW
BEGIN
	DECLARE existe INT;

	SELECT COUNT(*) INTO existe
	FROM ParteIncidencia
	WHERE reserva = new.reserva AND cod = new.parte;

-- Si no existe, lanzar error
IF existe = 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'La reserva de vuelo seleccionado no corresponde a la reserva registrada en el parte de esta incidencia.';
END IF;
END$$

DELIMITER ;

-- controlar que al crear un paquete el precio de compra sea menor que el precio de venta y ambos sean numeros positivos.
DELIMITER $$

CREATE TRIGGER comprobar_precios_paquete
BEFORE INSERT ON paquete
FOR EACH ROW
BEGIN

IF new.p_compra > new.p_venta THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'El paquete debe crearse un un precio de venta superior al precio de compra.';
END IF;

IF new.p_compra < 0 or new.p_venta < 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Los precios del paquete deben ser positivos.';
END IF;
END$$

DELIMITER ;

-- lo mismo para update
DELIMITER $$
CREATE TRIGGER comprobar_precios_paquete_update
BEFORE UPDATE ON paquete
FOR EACH ROW
BEGIN
IF new.p_compra > new.p_venta THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'El paquete debe tener un precio de venta superior al precio de compra.';
END IF;
IF new.p_compra < 0 or new.p_venta < 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Los precios del paquete deben ser positivos.';
END IF;
END$$
DELIMITER ;

-- Validar fechas de reserva (fecha inicio debe ser posterior a fecha reserva y anterior a fecha fin)
DELIMITER $$
CREATE TRIGGER validar_fechas_reserva
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.f_ini <= NEW.f_reserva THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de inicio debe ser posterior a la fecha de reserva.';
    END IF;
    IF NEW.f_fin <= NEW.f_ini THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de fin debe ser posterior a la fecha de inicio.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validar_fechas_reserva_update
BEFORE UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.f_ini <= NEW.f_reserva THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de inicio debe ser posterior a la fecha de reserva.';
    END IF;
    IF NEW.f_fin <= NEW.f_ini THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de fin debe ser posterior a la fecha de inicio.';
    END IF;
END$$
DELIMITER ;

-- Validar fechas del detalle de reserva (deben estar dentro del rango de la reserva)
DELIMITER $$
CREATE TRIGGER validar_fechas_detalle_reserva
BEFORE INSERT ON DetalleReserva
FOR EACH ROW
BEGIN
    DECLARE f_ini_reserva DATE;
    DECLARE f_fin_reserva DATE;
    
    SELECT f_ini, f_fin INTO f_ini_reserva, f_fin_reserva
    FROM Reserva
    WHERE num = NEW.reserva;
    
    IF NEW.f_entrada < f_ini_reserva OR NEW.f_entrada > f_fin_reserva THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de entrada debe estar dentro del período de la reserva.';
    END IF;
    
    IF NEW.f_salida < f_ini_reserva OR NEW.f_salida > f_fin_reserva THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de salida debe estar dentro del período de la reserva.';
    END IF;
    
    IF NEW.f_salida <= NEW.f_entrada THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de salida debe ser posterior a la fecha de entrada.';
    END IF;
END$$
DELIMITER ;

-- Validar que solo clientes activos puedan hacer reservas
DELIMITER $$
CREATE TRIGGER validar_cliente_activo
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    DECLARE cliente_activo BOOLEAN;
    
    SELECT activo INTO cliente_activo
    FROM Cliente
    WHERE DNI = NEW.cliente;
    
    IF cliente_activo = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pueden crear reservas para clientes inactivos.';
    END IF;
END$$
DELIMITER ;

-- Validar número de viajeros positivo
DELIMITER $$
CREATE TRIGGER validar_num_viajeros
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.n_viajeros <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de viajeros debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validar_num_viajeros_update
BEFORE UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.n_viajeros <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de viajeros debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;

-- Validar que las fechas del paquete sean coherentes
DELIMITER $$
CREATE TRIGGER validar_fechas_paquete
BEFORE INSERT ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.f_fin <= NEW.f_ini THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de fin del paquete debe ser posterior a la fecha de inicio.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validar_fechas_paquete_update
BEFORE UPDATE ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.f_fin <= NEW.f_ini THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de fin del paquete debe ser posterior a la fecha de inicio.';
    END IF;
END$$
DELIMITER ;

-- Validar que el precios en TipoHabitacion sea positivo
DELIMITER $$
CREATE TRIGGER validar_precio_habitacion
BEFORE INSERT ON TipoHabitacion
FOR EACH ROW
BEGIN
    IF NEW.precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio de la habitación debe ser positivo.';
    END IF;
END$$
DELIMITER ;

-- Validar que el precios y el numero de plazas en ViviendaTuristica sean positivos
DELIMITER $$
CREATE TRIGGER validar_precio_vivienda
BEFORE INSERT ON ViviendaTuristica
FOR EACH ROW
BEGIN
    IF NEW.precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio de la vivienda turística debe ser positivo.';
    END IF;
    IF NEW.plazas <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de plazas debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;

-- Validar que el número de habitaciones del hotel sea positivo
DELIMITER $$
CREATE TRIGGER validar_habitaciones_hotel
BEFORE INSERT ON Hotel
FOR EACH ROW
BEGIN
    IF NEW.n_habitaciones <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de habitaciones debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;

-- Validar que los días en DetallePaquete sean positivos
DELIMITER $$
CREATE TRIGGER validar_dias_paquete
BEFORE INSERT ON DetallePaquete
FOR EACH ROW
BEGIN
    IF NEW.dias <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El número de días debe ser mayor a cero.';
    END IF;
END$$
DELIMITER ;

-- Validar que el precio de vuelo sea positivo
DELIMITER $$
CREATE TRIGGER validar_precio_vuelo
BEFORE INSERT ON Vuelo
FOR EACH ROW
BEGIN
    IF NEW.precio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio del vuelo debe ser positivo.';
    END IF;
END$$
DELIMITER ;
