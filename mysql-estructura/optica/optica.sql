DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

DROP TABLE IF EXISTS direccion_proveedor;

CREATE TABLE direccion_proveedor (
  id_direccion_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  calle VARCHAR(255) NOT NULL,
  numero INT NOT NULL,
  piso INT NOT NULL,
  puerta VARCHAR(5) NOT NULL,
  ciudad VARCHAR(45) NOT NULL
);

DROP TABLE IF EXISTS proveedor;

CREATE TABLE proveedor (
  id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  direccion INT NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  fax VARCHAR(20) NOT NULL,
  nif VARCHAR(15) NOT NULL,
  FOREIGN KEY (direccion) REFERENCES direccion_proveedor (id_direccion_proveedor)
);

DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
  id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  direccion_cliente VARCHAR(255) NOT NULL,
  telefono_cliente VARCHAR(15) NOT NULL,
  correo_electronico_cliente VARCHAR(45) NOT NULL,
  fecha_registro_cliente DATE NOT NULL,
  nuevo_cliente TINYINT NOT NULL,
  id_cliente_que_recomienda INT NULL,
  FOREIGN KEY (id_cliente_que_recomienda) REFERENCES clientes (id_cliente)
);

DROP TABLE IF EXISTS empleados;

CREATE TABLE empleados (
  id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

DROP TABLE IF EXISTS monturas;

CREATE TABLE monturas (
  id_montura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_montura VARCHAR(45) NOT NULL
);

DROP TABLE IF EXISTS gafas;

CREATE TABLE gafas (
  id_gafa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  marca_gafa VARCHAR(45) NOT NULL,
  graducion_izq FLOAT NOT NULL,
  graducacion_drc FLOAT NOT NULL,
  tipo_montura INT NOT NULL,
  color_montura VARCHAR(45) NOT NULL,
  color_lente_izq VARCHAR(45) NOT NULL,
  color_lente_drc VARCHAR(45) NOT NULL,
  precio INT NOT NULL,
  id_montura INT NOT NULL,
  id_proveedor INT NOT NULL,
  id_venta INT NOT NULL,
  FOREIGN KEY (id_montura) REFERENCES monturas (id_montura),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor)
);

DROP TABLE IF EXISTS ventas;

CREATE TABLE ventas (
  id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  gafa_vendida INT NOT NULL,
  empleado_que_vende INT NOT NULL,
  fecha_venta DATETIME NOT NULL,
  FOREIGN KEY (gafa_vendida) REFERENCES gafas (id_gafa),
  FOREIGN KEY (empleado_que_vende) REFERENCES empleados (id_empleado),
  FOREIGN KEY (id_venta) REFERENCES clientes (id_cliente)
);

-- monturas

INSERT INTO monturas VALUES 
(1, 'Flotante'),
(2, 'Pasta'),
(3, 'Metálica');

-- clientes

INSERT INTO clientes VALUES 
(1, 'Calle de la piruleta', '666666666', 'cliente1@gmail.com', '2020-01-01', 0, NULL),
(2, 'Calle eufrasio', '345432345', 'cliente2@gmail.com', '2020-01-01', 0, NULL),
(3, 'Calle de la piruleta', '666666456', 'cliente2@gmail.com', '2020-01-01', 1, 1);

-- direccion_proveedor

INSERT INTO direccion_proveedor VALUES 
(1,'Calle de la piruleta1', 1, 1, 'A', 'Madrid'),
(2,'Calle de la piruleta2', 2, 1, 'A', 'Barcelona'),
(3,'Calle de la piruleta3', 3, 1, 'A', 'Málaga');

-- proveedor

INSERT INTO proveedor VALUES 
(1,'Proveedor1', 1, '666666667', '666666666', '123456789A'),
(2,'Proveedor2', 2, '666666668', '666666666', '123456789B'),
(3,'Proveedor3', 3, '666666669', '666666666', '123456789C');

-- empleados

INSERT INTO empleados VALUES 
(1),
(2),
(3),
(4);

-- gafas

INSERT INTO gafas VALUES 
(1,'Rayban', 1.5, 2.5, 1, 'Negra', 'Azul', 'Azul', 100, 1, 1, 1),
(2,'Oklay', 1.5, 2.5, 2, 'Negra', 'Azul', 'Azul', 100, 2, 2, 2),
(3,'Rayban', 1.5, 2.5, 3, 'Negra', 'Azul', 'Azul', 100, 3, 3, 3);

-- ventas

INSERT INTO ventas VALUES 
(1, 1, 1, '2020-01-01 01:00:00'),
(2, 2, 2, '2020-01-01 02:00:00'),
(3, 3, 3, '2020-01-01 03:00:00');