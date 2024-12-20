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
  FOREIGN KEY (id_montura) REFERENCES monturas (id_montura),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor)
);

DROP TABLE IF EXISTS ventas;

CREATE TABLE ventas (
  id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  gafa_vendida INT NOT NULL,
  empleado_que_vende INT NOT NULL,
  cliente_que_compra INT NOT NULL,
  fecha_venta DATETIME NOT NULL,
  FOREIGN KEY (gafa_vendida) REFERENCES gafas (id_gafa),
  FOREIGN KEY (empleado_que_vende) REFERENCES empleados (id_empleado),
  FOREIGN KEY (cliente_que_compra) REFERENCES clientes (id_cliente),
  UNIQUE (gafa_vendida, empleado_que_vende, cliente_que_compra)
);

-- monturas

INSERT INTO monturas (tipo_montura) VALUES 
('Flotante'),
('Pasta'),
('Metálica');

-- clientes



INSERT INTO clientes (direccion_cliente,telefono_cliente, correo_electronico_cliente, fecha_registro_cliente, nuevo_cliente, id_cliente_que_recomienda) VALUES 
('Calle de la piruleta', '666666666', 'cliente1@gmail.com', '2020-01-01', 0, NULL),
('Calle eufrasio', '345432345', 'cliente2@gmail.com', '2020-01-01', 0, NULL),
('Calle de la piruleta', '666666456', 'cliente2@gmail.com', '2020-01-01', 1, 1);

-- direccion_proveedor

INSERT INTO direccion_proveedor (calle, numero, piso, puerta, ciudad ) VALUES 
('Calle de la piruleta1', 1, 1, 'A', 'Madrid'),
('Calle de la piruleta2', 2, 1, 'A', 'Barcelona'),
('Calle de la piruleta3', 3, 1, 'A', 'Málaga');

-- proveedor

INSERT INTO proveedor(nombre,direccion,telefono,fax, nif) VALUES 
('Proveedor1', 1, '666666667', '666666666', '123456789A'),
('Proveedor2', 2, '666666668', '666666666', '123456789B'),
('Proveedor3', 3, '666666669', '666666666', '123456789C');

-- empleados

INSERT INTO empleados VALUES 
(1),
(2),
(3),
(4);

-- gafas


INSERT INTO gafas(marca_gafa, graducion_izq, graducacion_drc,tipo_montura, color_montura, color_lente_izq, color_lente_drc, precio, id_montura, id_proveedor) VALUES 
('Rayban', 1.5, 2.5, 1, 'Negra', 'Azul', 'Azul', 100, 1, 1),
('Oklay', 1.5, 2.5, 2, 'Negra', 'Azul', 'Azul', 100, 2, 2),
('Rayban', 1.5, 2.5, 3, 'Negra', 'Azul', 'Azul', 100, 3, 3);

-- ventas

INSERT INTO ventas(gafa_vendida, empleado_que_vende, cliente_que_compra, fecha_venta) VALUES 
(1, 1, 1, '2020-01-01 01:00:00'),
(2, 2, 2, '2020-01-01 02:00:00'),
(3, 3, 3, '2020-01-01 03:00:00');



/*

Consultas 

Llista el total de compres d’un client/a.

SELECT COUNT(id_venta)
FROM ventas
JOIN clientes
ON clientes.id_cliente = ventas.id_venta
WHERE clientes.id_cliente = 2

Llista les diferents ulleres que ha venut un empleat durant un any.

SELECT gafas.id_gafa
FROM gafas
JOIN ventas
ON gafas.id_gafa = ventas.gafa_vendida
JOIN empleados
ON ventas.empleado_que_vende = empleados.id_empleado
WHERE YEAR(fecha_venta) < 2021 AND YEAR (fecha_venta) >= 2020 AND empleados.id_empleado = 1


Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

SELECT proveedor.nombre
FROM proveedor
JOIN gafas
ON proveedor.id_proveedor = gafas.id_proveedor
JOIN ventas
ON ventas.gafa_vendida = gafas.id_gafa

*/