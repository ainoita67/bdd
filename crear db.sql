drop schema viajes;
create schema viajes;
use viajes;

CREATE TABLE CP (
    cp VARCHAR(10) PRIMARY KEY,
    poblacion VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL
);

CREATE TABLE Cliente (
    DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    tlfno VARCHAR(20) NOT NULL,
    cp VARCHAR(5) NOT NULL,
    f_alta DATE NOT NULL,
    f_baja DATE,
    observaciones VARCHAR(255),
    activo BOOLEAN NOT NULL
);

CREATE TABLE Empleado (
    DNI VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    tlfno VARCHAR(20) NOT NULL,
    cp VARCHAR(5) NOT NULL,
    f_alta DATE NOT NULL,
    f_baja DATE,
    observaciones VARCHAR(255),
    sede VARCHAR(10) NOT NULL
);

CREATE TABLE Sede (
    cod VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    cp VARCHAR(5) NOT NULL,
    cif VARCHAR(20) NOT NULL,
    iban VARCHAR(20) NOT NULL,
    director VARCHAR(20) NOT NULL
);

CREATE TABLE Categoria (
    cod VARCHAR(10) PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    iva DECIMAL(5,2) NOT NULL
);

CREATE TABLE Hotel (
    cod VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    f_alta DATE NOT NULL,
    f_baja DATE,
    direccion VARCHAR(255) NOT NULL,
    cp VARCHAR(5) NOT NULL,
    cif VARCHAR(20) NOT NULL,
    tfno VARCHAR(20) NOT NULL,
    n_habitaciones INT NOT NULL,
    categoria VARCHAR(10)  NOT NULL
);

CREATE TABLE TipoHabitacion (
    hotel VARCHAR(10) ,
    tipo VARCHAR(50),
    estancia VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (hotel, tipo, estancia)
);

CREATE TABLE Propietario (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    tfno VARCHAR(20) NOT NULL
);

CREATE TABLE ViviendaTuristica (
    cod VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    plazas INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    cp VARCHAR(5) NOT NULL,
    propietario VARCHAR(20) NOT NULL,
    categoria VARCHAR(10) NOT NULL
);

CREATE TABLE Mayorista (
    cod VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Paquete (
    cod VARCHAR(10) PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    p_compra DECIMAL(10,2) NOT NULL,
    p_venta DECIMAL(10,2) NOT NULL,
    f_ini DATE NOT NULL,
    f_fin DATE NOT NULL,
    mayorista VARCHAR(10) NOT NULL
);

CREATE TABLE DetallePaquete (
    paquete VARCHAR(10),
    num INT,
    dias INT NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    hotel VARCHAR(10) NOT NULL,
    tipo_habitacion VARCHAR(50) NOT NULL,
    tipo_estancia VARCHAR(50) NOT NULL,
    PRIMARY KEY (paquete, num)
);

CREATE TABLE Reserva (
    num INT PRIMARY KEY,
    f_reserva DATE NOT NULL,
    f_ini DATE NOT NULL,
    f_fin DATE NOT NULL,
    n_viajeros INT NOT NULL,
    menores2 BOOLEAN NOT NULL,
    observaciones VARCHAR(255),
    empleado VARCHAR(20) NOT NULL,
    cliente VARCHAR(20) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
	CHECK (tipo IN ('comun', 'paquete'))
);

CREATE TABLE DetalleReserva (
    reserva INT,
    num INT,
    f_entrada DATE NOT NULL,
    f_salida DATE NOT NULL,
    confirmado BOOLEAN,
    extras VARCHAR(255),
    costo_ext DECIMAL(10,2) NOT NULL,
    precio_tot DECIMAL(10,2) NOT NULL,
    hotel VARCHAR(10),
    tipo_habitacion VARCHAR(50),
    tipo_estancia VARCHAR(50),
    vivienda_turistica VARCHAR(10),
    PRIMARY KEY (reserva, num)
);

CREATE TABLE Rpaquete (
    num INT PRIMARY KEY,
    anticipo DECIMAL(10,2) NOT NULL,
    coste_seguro DECIMAL(10,2),
    seguro VARCHAR(100) NOT NULL,
    paquete VARCHAR(10) NOT NULL
);

CREATE TABLE Contrato (
    cod INT PRIMARY KEY,
    reserva INT NOT NULL,
    firmado_pagado BOOLEAN NOT NULL,
    pago_contrato DECIMAL(10,2) NOT NULL,
    pago_adelantado DECIMAL(10,2) NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE Vuelo (
    origen VARCHAR(100),
    destino VARCHAR(100),
    compania VARCHAR(100),
    precio DECIMAL(10,2) NOT NULL,
    observaciones VARCHAR(255),
    PRIMARY KEY (origen, destino, compania)
);

CREATE TABLE Rvuelo (
    origen VARCHAR(100),
    destino VARCHAR(100),
    compania VARCHAR(100),
    fecha_hora DATETIME NOT NULL,
    reserva INT,
    PRIMARY KEY (origen, destino, compania, reserva)
);

CREATE TABLE ParteIncidencia (
    cod VARCHAR(10) PRIMARY KEY,
    reserva INT NOT NULL
);

CREATE TABLE DetalleIncidenciaVuelo (
    parte VARCHAR(10),
    num INT,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    compania VARCHAR(100) NOT NULL,
    reserva INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    transmitida BOOLEAN NOT NULL,
    resuelta BOOLEAN NOT NULL,
    cerrada BOOLEAN NOT NULL,
    PRIMARY KEY (parte, num)
);

CREATE TABLE DetalleIncidenciaEstancia (
    parte VARCHAR(10),
    num INT,
    reserva INT NOT NULL,
    detalle INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    transmitida BOOLEAN NOT NULL,
    resuelta BOOLEAN NOT NULL,
    cerrada BOOLEAN NOT NULL,
    PRIMARY KEY (parte, num)
);

ALTER TABLE Cliente
    ADD FOREIGN KEY (cp) REFERENCES CP(cp) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Empleado
    ADD FOREIGN KEY (cp) REFERENCES CP(cp) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Sede
    ADD FOREIGN KEY (cp) REFERENCES CP(cp) ON DELETE RESTRICT ON UPDATE CASCADE;
    
ALTER TABLE Hotel
	ADD FOREIGN KEY (cp) REFERENCES CP(cp) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (categoria) REFERENCES Categoria(cod) ON DELETE RESTRICT ON UPDATE CASCADE;
    
ALTER TABLE TipoHabitacion
    ADD FOREIGN KEY (hotel) REFERENCES Hotel(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ViviendaTuristica
	ADD FOREIGN KEY (cp) REFERENCES CP(cp) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (propietario) REFERENCES Propietario(dni) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (categoria) REFERENCES Categoria(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Paquete
    ADD FOREIGN KEY (mayorista) REFERENCES Mayorista(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE DetallePaquete
    ADD FOREIGN KEY (hotel, tipo_habitacion, tipo_estancia) REFERENCES TipoHabitacion(hotel, tipo, estancia) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (paquete) REFERENCES Paquete(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Reserva
    ADD FOREIGN KEY (empleado) REFERENCES Empleado(DNI) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (cliente) REFERENCES Cliente(DNI) ON DELETE RESTRICT ON UPDATE CASCADE;
    
ALTER TABLE Rpaquete
    ADD FOREIGN KEY (paquete) REFERENCES Paquete(cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (num) REFERENCES Reserva(num) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE DetalleReserva
    ADD FOREIGN KEY (reserva) REFERENCES Reserva(num) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (hotel, tipo_habitacion, tipo_estancia) REFERENCES TipoHabitacion(hotel, tipo, estancia) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (vivienda_turistica) REFERENCES ViviendaTuristica(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Contrato
    ADD FOREIGN KEY (reserva) REFERENCES Reserva(num) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Rvuelo
    ADD FOREIGN KEY (reserva) REFERENCES Rpaquete(num) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (origen, destino, compania) REFERENCES Vuelo(origen, destino, compania) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE ParteIncidencia
    ADD FOREIGN KEY (reserva) REFERENCES Reserva(num) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE DetalleIncidenciaVuelo
    ADD FOREIGN KEY (parte) REFERENCES ParteIncidencia(cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (origen, destino, compania, reserva) REFERENCES Rvuelo(origen, destino, compania, reserva) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE DetalleIncidenciaEstancia
    ADD FOREIGN KEY (parte) REFERENCES ParteIncidencia(cod) ON DELETE RESTRICT ON UPDATE CASCADE,
    ADD FOREIGN KEY (reserva, detalle) REFERENCES DetalleReserva(reserva, num) ON DELETE RESTRICT ON UPDATE CASCADE;


ALTER TABLE Empleado
    ADD FOREIGN KEY (sede) REFERENCES Sede(cod) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE Sede
    ADD FOREIGN KEY (director) REFERENCES Empleado(DNI) ON DELETE RESTRICT ON UPDATE CASCADE;
