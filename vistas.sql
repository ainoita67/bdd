-- ver los paquetes disponibles a dia de hoy
CREATE VIEW PaquetesDisponibles AS
SELECT cod, descripcion, p_compra, p_venta, f_ini, f_fin, mayorista
FROM Paquete
WHERE CURDATE() BETWEEN f_ini AND f_fin;

-- ver los contratos que hay planeados para firmar esta semana
CREATE VIEW PlanningSemanalContratos AS
SELECT
    c.cod AS contrato,
    c.reserva,
    c.fecha,
    DAYNAME(c.fecha) AS dia_semana,
    r.cliente
FROM Contrato c
JOIN reserva r ON c.reserva = r.num
WHERE WEEK(c.fecha, 1) = WEEK(CURDATE(), 1) AND YEAR(c.fecha) = YEAR(CURDATE())
ORDER BY c.fecha;

-- ver los contratos o reservas realizados hoy
CREATE VIEW InformeDiarioContratos AS
SELECT
	"reserva" as tipo,
    null as contrato,
    num as reserva, 
    f_ini, 
    f_fin, 
    n_viajeros, 
    empleado, 
    cliente, 
    tipo as tipo_reserva
FROM Reserva r
WHERE DATE(f_reserva) = DATE(CURDATE())

UNION

SELECT
	"contrato" as tipo,
    c.cod as contrato,
    r.num as reserva, 
    r.f_ini, 
    r.f_fin, 
    r.n_viajeros, 
    r.empleado, 
    r.cliente, 
    r.tipo as tipo_reserva
FROM Contrato c 
JOIN Reserva r on c.reserva=r.num
WHERE DATE(fecha) = DATE(CURDATE())

ORDER BY empleado;


-- informe de incidencias pendientes
DROP VIEW IF EXISTS IncidenciasPendientes;
CREATE VIEW IncidenciasPendientes AS
SELECT 
    d.parte,
    d.num as incidencia,
    'Vuelo' as tipo_incidencia,
    c.cod as contrato,
    d.descripcion, 
    d.transmitida, 
    d.resuelta, 
    d.cerrada,
    c.fecha as fecha_contrato
FROM DetalleIncidenciaVuelo d
JOIN ParteIncidencia p ON d.parte = p.cod
JOIN Reserva r ON r.num = p.reserva
JOIN Contrato c ON r.num = c.reserva
WHERE d.resuelta = 0 or d.cerrada = 0

UNION ALL

SELECT 
    d.parte,
    d.num as incidencia,
    'Estancia' as tipo_incidencia,
    c.cod as contrato,
    d.descripcion, 
    d.transmitida, 
    d.resuelta, 
    d.cerrada,
    c.fecha as fecha_contrato
FROM DetalleIncidenciaEstancia d
JOIN ParteIncidencia p ON d.parte = p.cod
JOIN Reserva r ON r.num = p.reserva
JOIN Contrato c ON r.num = c.reserva
WHERE d.resuelta = 0 or d.cerrada = 0
ORDER BY fecha_contrato;

-- Vista para hoteles disponibles con sus categorías y precios maximos y minimos
CREATE VIEW HotelesDisponibles AS
SELECT 
    h.cod,
    h.nombre,
    h.direccion,
    cp.poblacion,
    cp.provincia,
    h.tfno,
    h.n_habitaciones,
    c.descripcion as categoria,
    COUNT(th.tipo) as tipos_habitacion_disponibles,
    MIN(th.precio) as precio_minimo,
    MAX(th.precio) as precio_maximo
FROM Hotel h
LEFT JOIN CP cp ON h.cp = cp.cp
LEFT JOIN Categoria c ON h.categoria = c.cod
LEFT JOIN TipoHabitacion th ON h.cod = th.hotel
WHERE h.f_baja IS NULL
GROUP BY h.cod, h.nombre, h.direccion, cp.poblacion, cp.provincia, h.tfno, h.n_habitaciones, c.descripcion
ORDER BY cp.provincia, cp.poblacion, h.nombre;

-- Vista de viviendas turísticas disponibles
CREATE VIEW ViviendasDisponibles AS
SELECT 
    vt.cod,
    vt.nombre,
    vt.plazas,
    vt.precio,
    vt.direccion,
    cp.poblacion,
    cp.provincia,
    CONCAT(pr.nombre, ' - ', pr.email, ' - ', pr.tfno) as propietario_contacto,
    c.descripcion as categoria
FROM ViviendaTuristica vt
LEFT JOIN CP cp ON vt.cp = cp.cp
LEFT JOIN Propietario pr ON vt.propietario = pr.dni
LEFT JOIN Categoria c ON vt.categoria = c.cod
ORDER BY cp.provincia, cp.poblacion, vt.nombre;

-- Vista de contratos pendientes de pago
CREATE VIEW ContratosPendientesPago AS
SELECT 
    c.cod as contrato,
    c.reserva,
    c.fecha,
    c.pago_contrato,
    c.pago_adelantado,
    (c.pago_contrato - c.pago_adelantado) as saldo_pendiente,
    CONCAT(cl.nombre, ' ', cl.apellidos) as cliente,
    cl.tlfno as telefono_cliente,
    r.f_ini as fecha_viaje
FROM Contrato c
JOIN Reserva r ON c.reserva = r.num
JOIN Cliente cl ON r.cliente = cl.DNI
WHERE c.firmado_pagado = 0
    AND c.fecha <= CURDATE()
ORDER BY saldo_pendiente DESC;
