-- vistas

CREATE VIEW PaquetesDisponibles AS
SELECT cod, descripcion, p_compra, p_venta, f_ini, f_fin, mayorista
FROM Paquete
WHERE CURDATE() BETWEEN f_ini AND f_fin;

drop view PlanningSemanalContratos;
CREATE VIEW PlanningSemanalContratos AS
SELECT
    c.cod AS contrato,
    c.reserva,
    c.fecha,
    DAYNAME(c.fecha) AS dia_semana,
    r.cliente
FROM Contrato c
JOIN Reserva r ON c.reserva = r.num
WHERE WEEK(c.fecha, 1) = WEEK(CURDATE(), 1) AND YEAR(c.fecha) = YEAR(CURDATE())
ORDER BY c.fecha;



CREATE VIEW InformeDiariaContratos AS
SELECT
	"resertva" as tipo,
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