DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

-- categoria_productos

DROP TABLE IF EXISTS categoria_productos;

CREATE TABLE IF NOT EXISTS categoria_productos (
    id_categoria_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria_producto VARCHAR(45) NOT NULL
);

-- categoria_pizza`
DROP TABLE IF EXISTS categorias_pizza ;

CREATE TABLE IF NOT EXISTS categorias_pizza(
  id_categoria_pizza INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_categoria_pizza VARCHAR(45) NOT NULL,
  id_categoria_producto INT NOT NULL,
  FOREIGN KEY (id_categoria_producto) REFERENCES categoria_productos (id_categoria_producto)
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
  tienda_comanda TINYINT NOT NULL,
  precio_comanda FLOAT NOT NULL,
  id_cliente INT NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- producto

DROP TABLE IF EXISTS productos ;

CREATE TABLE IF NOT EXISTS productos (
  id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre_producto VARCHAR(50) NOT NULL,
  descripcion_producto VARCHAR(200) NULL,
  imagen_producto BLOB NOT NULL,
  precio_producto FLOAT NOT NULL,
  id_categoria_producto INT NOT NULL,
  id_categoria_pizza INT,
  FOREIGN KEY (id_categoria_producto) REFERENCES categoria_productos(id_categoria_producto),
  FOREIGN KEY (id_categoria_pizza) REFERENCES categorias_pizza (id_categoria_pizza)
);

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
  provincia VARCHAR(100) NOT NULL,
  id_comanda INT NOT NULL,
  FOREIGN KEY (id_comanda) REFERENCES comandas (id_comanda)
);

-- empleados
DROP TABLE IF EXISTS empleados ;

CREATE TABLE IF NOT EXISTS empleados (
  id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_tienda INT NOT NULL,
  empledo_nombre VARCHAR(45) NOT NULL,
  empleado_apellidos VARCHAR(100) NOT NULL,
  empleado_nif VARCHAR(10) NOT NULL,
  empleado_telefono INT NOT NULL,
  empleado_cocinero TINYINT NOT NULL,
  empleado_repartidor TINYINT NULL,
  FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda)
);

-- reparto_docmicilio
DROP TABLE IF EXISTS reparto_docmicilio;

CREATE TABLE IF NOT EXISTS reparto_docmicilio (
  id_reparto_docmicilio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_repartidor INT NOT NULL,
  fecha_hora_reparrto DATETIME NOT NULL,
  FOREIGN KEY (id_repartidor) REFERENCES empleados(id_empleados)
);

INSERT INTO categoria_productos VALUES (1, 'Pizza');
INSERT INTO categoria_productos VALUES (2, 'Hamburguesas');
INSERT INTO categoria_productos VALUES (3, 'Bebidas');

INSERT INTO categorias_pizza VALUES (1, 'Invierno', 1);
INSERT INTO categorias_pizza VALUES (2, 'Invierno', 1);
INSERT INTO categorias_pizza VALUES (3, 'Invierno', 1);
INSERT INTO categorias_pizza VALUES (4, 'Invierno', 1);

INSERT INTO clientes VALUES (1, 'Juan', 'Perez', 'Calle de la piruleta', 28000, 'Madrid', 'Madrid', 666666667);
INSERT INTO clientes VALUES (2, 'Maria', 'Garcia', 'Calle de la piruleta2', 28000, 'Madrid', 'Madrid', 666666668);
INSERT INTO clientes VALUES (3, 'Pedro', 'Gonzalez', 'Calle de la piruleta3', 28000, 'Madrid', 'Madrid', 666666669);

INSERT INTO comandas VALUES (1, '12:00', 1, 0, 10, 1);
INSERT INTO comandas VALUES (2, '12:00', 0, 1, 10, 2);
INSERT INTO comandas VALUES (3, '12:00', 1, 0, 10, 3);

INSERT INTO productos VALUES (1, 'Pizza', 'Pizza de queso', 'imagen', 10, 1, 1);
INSERT INTO productos VALUES (2, 'Hamburguesa', 'Cheese-King', 'imagen', 10, 2, NULL);
INSERT INTO productos VALUES (3, 'Coca-cola', 'Zero', 'imagen', 2.5, 3, NULL);
INSERT INTO productos VALUES (4, 'Pizza', 'Pizza de pollo', 'imagen', 10, 1, 1);

INSERT INTO comandas_productos VALUES (1, 1, 1, 3);
INSERT INTO comandas_productos VALUES (2, 2, 2, 4);
INSERT INTO comandas_productos VALUES (3, 3, 3, 2);

INSERT INTO tienda VALUES (1, 'Calle de la piruleta', 28000, 'Madrid', 'Madrid', 1);
INSERT INTO tienda VALUES (2, 'Calle de la piruleta2', 28000, 'Madrid', 'Madrid', 2);
INSERT INTO tienda VALUES (3, 'Calle de la piruleta3', 28000, 'Madrid', 'Madrid', 3);

INSERT INTO empleados VALUES (1, 1, 'Juan', 'Perez', '123456789', 666666667, 1, 0);
INSERT INTO empleados VALUES (2, 1, 'Maria', 'Garcia', '123456789', 666666668, 0, 1);
INSERT INTO empleados VALUES (3, 1, 'Pedro', 'Gonzalez', '123456789', 666666669, 1, 0);

INSERT INTO reparto_docmicilio VALUES (1, 1, '2021-01-01 12:00');
INSERT INTO reparto_docmicilio VALUES (2, 2, '2021-01-01 12:30');

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
