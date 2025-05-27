-- controlar que un un detalle reserva solo coja tipos de habitaciones disponibles en el paquete que esta reservado en la reserva del paquete

DELIMITER $$

CREATE TRIGGER comprobar_tipo_habitacion_paquete
BEFORE INSERT ON DetalleReserva
FOR EACH ROW
BEGIN
  DECLARE tipo_reserva VARCHAR(50);
  DECLARE cod_paquete VARCHAR(10);
  DECLARE existe INT;

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
	WHERE reserva = new.reserva;

-- Si no existe, lanzar error
IF existe = 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'El detalle de reserva seleccionado no corresponde a la reserva registrada en el parte de esta incidencia.';
END IF;
END$$

DELIMITER ;

-- controlar que un un detalle de incidencia de vuelo solo coja reservas de vuelos de la reserva asociada al parte
DELIMITER $$

CREATE TRIGGER comprobar_reserva_vuelo_incidencia
BEFORE INSERT ON DetalleIncidenciaVuelo
FOR EACH ROW
BEGIN
	DECLARE existe INT;

	SELECT COUNT(*) INTO existe
	FROM ParteIncidencia
	WHERE reserva = new.reserva;

-- Si no existe, lanzar error
IF existe = 0 THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'La reserva de vuelo seleccionado no corresponde a la reserva registrada en el parte de esta incidencia.';
END IF;
END$$

DELIMITER ;
