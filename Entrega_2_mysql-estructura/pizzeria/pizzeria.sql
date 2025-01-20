DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

-- categoria_productos

DROP TABLE IF EXISTS categoria_productos;

CREATE TABLE IF NOT EXISTS categoria_productos (
    id_categoria_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria_producto VARCHAR(45) NOT NULL
);

-- categoria_pizza
DROP TABLE IF EXISTS categorias_pizza ;

CREATE TABLE IF NOT EXISTS categorias_pizza (
  id_categoria_pizza INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria_pizza VARCHAR(45) NOT NULL
);

-- clientes

DROP TABLE IF EXISTS clientes ;

CREATE TABLE IF NOT EXISTS clientes (
  id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_cliente VARCHAR(45) NOT NULL,
  apellidos_cliente VARCHAR(120) NOT NULL,
  direccion_cliente VARCHAR(150) NOT NULL UNIQUE,
  cp_cliente INT NOT NULL,
  localidad_cliente VARCHAR(50) NOT NULL,
  provincia_cliente VARCHAR(50) NOT NULL,
  telefono_cliente INT NULL
);

-- comanda

DROP TABLE IF EXISTS comandas;

CREATE TABLE IF NOT EXISTS comandas (
  id_comanda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  hora_comanda VARCHAR(45) NOT NULL,
  domicilio_comanda BOOLEAN NOT NULL,
  id_tienda INT NOT NULL,
  precio_comanda FLOAT NOT NULL,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
  FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)

);

-- producto

DROP TABLE IF EXISTS productos ;

CREATE TABLE IF NOT EXISTS productos (
  id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(50) NOT NULL,
  descripcion_producto VARCHAR(200) NULL,
  imagen_producto VARCHAR(100) NOT NULL,
  precio_producto FLOAT NOT NULL,
  id_categoria_producto INT NOT NULL,
  id_categoria_pizza INT,
  FOREIGN KEY (id_categoria_producto) REFERENCES categoria_productos(id_categoria_producto),
  FOREIGN KEY (id_categoria_pizza) REFERENCES categorias_pizza (id_categoria_pizza)
);

-- comandas_productos

DROP TABLE IF EXISTS comandas_productos;

CREATE TABLE IF NOT EXISTS comandas_productos (
  id_comanda_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_comanda INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad_productos INT,
  UNIQUE (id_comanda, id_producto),
  FOREIGN KEY (id_comanda) REFERENCES comandas (id_comanda),
  FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);

-- tienda
DROP TABLE IF EXISTS tienda;

CREATE TABLE IF NOT EXISTS tienda(
  id_tienda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  direccion_tienda VARCHAR(150) NOT NULL,
  cp INT NOT NULL,
  localidad_tienda VARCHAR(100) NOT NULL,
  provincia VARCHAR(100) NOT NULL
);

-- empleados
DROP TABLE IF EXISTS empleados ;

CREATE TABLE IF NOT EXISTS empleados (
  id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_tienda INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  nif VARCHAR(10) NOT NULL,
  telefono INT NOT NULL,
  cocinero TINYINT NOT NULL,
  repartidor TINYINT NULL,
  FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda)
);

-- reparto_docmicilio
DROP TABLE IF EXISTS reparto_docmicilio;

CREATE TABLE IF NOT EXISTS reparto_docmicilio (
  id_reparto_docmicilio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_repartidor INT NOT NULL,
  id_comanda INT NOT NULL,
  fecha_hora_reparto DATETIME NOT NULL,
  FOREIGN KEY (id_repartidor) REFERENCES empleados(id_empleado),
  FOREIGN KEY (id_comanda) REFERENCES comandas(id_comanda)
);

INSERT INTO categoria_productos(nombre_categoria_producto) VALUES 
('Pizza'), 
('Hamburguesas'), 
('Bebidas');

INSERT INTO categorias_pizza(nombre_categoria_pizza) VALUES 
('Invierno'),
('Primavera'), 
('Verano'), 
('Otoño');


INSERT INTO clientes (nombre_cliente, apellidos_cliente, direccion_cliente, cp_cliente, localidad_cliente, provincia_cliente, telefono_cliente) VALUES
('Juan', 'Perez', 'Calle de la piruleta', 28000, 'Madrid', 'Madrid', 666666667),
('Maria', 'Garcia', 'Calle de la piruleta2', 28000, 'Madrid', 'Madrid', 666666668),
('Pedro', 'Gonzalez', 'Calle de la piruleta3', 28000, 'Madrid', 'Madrid', 666666669);


INSERT INTO comandas (hora_comanda, domicilio_comanda, id_tienda, precio_comanda, id_cliente) VALUES
('12:00', 1, 1, 10, 1),
('12:00', 0, 2, 10, 2),
('12:00', 1, 3, 10, 3);

INSERT INTO productos (nombre_producto, descripcion_producto, imagen_producto, precio_producto, id_categoria_producto, id_categoria_pizza) VALUES
('Pizza quesada', 'Pizza de queso', 'www.imagen1.com', 10, 1, 1),
('Hamburguesa XXL', 'Cheese-King', 'www.imagen2.com', 10, 2, NULL),
('Coca-cola Zero', 'Zero', 'www.imagen3.com', 2.5, 3, NULL),
('Pizza ChikenRun', 'Pizza de pollo', 'www.imagen4.com', 10, 1, 1);



INSERT INTO comandas_productos (id_comanda, id_producto, cantidad_productos) VALUES
(1, 1, 3),
(2, 2, 4),
(3, 3, 2);


INSERT INTO tienda (direccion_tienda, cp, localidad_tienda, provincia) VALUES
('Calle de la piruleta', 28000, 'Madrid', 'Madrid'),
('Calle de la piruleta2', 28000, 'Madrid', 'Madrid'),
('Calle de la piruleta3', 28000, 'Madrid', 'Madrid');

INSERT INTO empleados (id_tienda, nombre, apellidos, nif, telefono, cocinero, repartidor) VALUES
(1, 'Juan', 'Perez', '123456789', 666666667, 1, 0),
(2, 'Maria', 'Garcia', '123456789', 666666668, 0, 1),
(3, 'Pedro', 'Gonzalez', '123456789', 666666669, 1, 0);


INSERT INTO reparto_docmicilio (id_repartidor, id_comanda, fecha_hora_reparto) VALUES
(1,1, '2021-01-01 12:00'),
(2,2, '2021-01-01 12:30');
/*

Consultas

Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.

SELECT COUNT(categoria_productos.id_categoria_producto)
FROM categoria_productos
JOIN productos
ON categoria_productos.id_categoria_producto = productos.id_categoria_producto
JOIN comandas_productos
ON productos.id_producto = comandas_productos.id_producto
JOIN tienda 
ON comandas_productos.id_comanda = tienda.id_comanda
WHERE productos.id_categoria_producto = 3 AND tienda.localidad_tienda = 'Madrid';

Llista quantes comandes ha efectuat un determinat empleat/da.

SELECT COUNT(comandas.id_comanda)
FROM comandas
JOIN tienda
ON comandas.id_comanda = tienda.id_comanda
JOIN
empleados
ON tienda.id_tienda = empleados.id_tienda
WHERE empleados.id_empleado = 1

*/