SELECT nombre FROM producto;

SELECT nombre, precio FROM producto;

SELECT * FROM producto;

SELECT nombre, precio, ROUND(precio * 1.10, 2) FROM producto;

SELECT nombre AS 'Nombre de producto', precio AS 'Euros', ROUND(precio *1.1, 2) AS 'Dolares Norteamericanos' FROM producto;

SELECT UPPER(nombre), precio FROM producto;

SELECT LOWER(nombre), precio FROM producto;

SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) FROM fabricante;

SELECT nombre, ROUND(precio, 1) FROM producto;

SELECT CEIL(precio) FROM producto;

SELECT fabricante.codigo FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

SELECT DISTINCT fabricante.codigo FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

SELECT nombre FROM fabricante ORDER BY nombre ASC;

SELECT nombre FROM fabricante ORDER BY nombre DESC;

SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

SELECT * FROM fabricante LIMIT 5;

SELECT * FROM fabricante LIMIT 2 OFFSET 3;

SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.codigo_fabricante = 2;

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto, fabricante;

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto, fabricante ORDER BY fabricante.nombre ASC;

SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto, fabricante;

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MIN(precio) FROM producto);

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MAX(precio) FROM producto);

SELECT producto.nombre, fabricante.nombre  FROM producto  JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo  WHERE LOWER (fabricante.nombre) = LOWER('Lenovo');

SELECT * , fabricante.nombre   FROM producto   JOIN fabricante  ON producto.codigo_fabricante = fabricante.codigo WHERE LOWER (fabricante.nombre) = LOWER('Crucial') AND producto.precio > 200;

SELECT * , fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE LOWER (fabricante.nombre) = LOWER('Asus') OR LOWER (fabricante.nombre) = LOWER('Hewlett-Packard') OR LOWER (fabricante.nombre) = LOWER('Seagate');

SELECT *, fabricante.nombre FROM producto JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre IN("Asus", "Hewlett-Packard", "Seagate");

SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE RIGHT (fabricante.nombre, 1) IN ('e');

SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;

SELECT fabricante.codigo, fabricante.nombre FROM fabricante WHERE EXISTS(SELECT 1 FROM producto WHERE producto.codigo_fabricante = fabricante.codigo);

SELECT fabricante.nombre, producto.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

SELECT fabricante.codigo, fabricante.nombre FROM fabricante WHERE NOT EXISTS(SELECT 1 FROM producto WHERE producto.codigo_fabricante = fabricante.codigo);

SELECT producto.nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE LOWER(fabricante.nombre) = LOWER('Lenovo'));

SELECT *  FROM producto  WHERE precio = (SELECT MAX(Precio) FROM producto WHERE codigo_fabricante = ( SELECT codigo_fabricante FROM fabricante WHERE LOWER(nombre) = LOWER('Lenovo')));

SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MAX(producto.precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = LOWER('Lenovo'));

SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = ( SELECT MIN(producto.precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = LOWER('Hewlett-Packard'));

SELECT producto.nombre  FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= (SELECT MAX(producto.precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = LOWER('Lenovo'));

SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo  WHERE fabricante.nombre = LOWER('ASUS')  AND producto.precio >= (SELECT AVG(producto.precio) FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = LOWER('ASUS'));

SELECT apellido1, apellido2, nombre FROM persona WHERE persona.tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR (fecha_nacimiento) = 1999;

SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND RIGHT(LOWER(nif), 1) = LOWER('K');

SELECT * FROM asignatura  WHERE cuatrimestre = '1' AND curso = '3' AND id_grado = 7;

SELECT persona.apellido1 AS 'Primer apellido', persona.apellido2 AS 'Segundo apellido', persona.nombre AS 'Nombre', departamento.nombre AS 'Nombre del departamento' FROM profesor JOIN persona ON profesor.id_profesor = persona.id JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' ORDER BY persona.apellido1, persona.apellido2, persona.nombre;

SELECT asignatura.nombre, anyo_inicio, anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.nif = '26902806M';

SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON profesor.id_departamento = departamento.id JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor JOIN grado ON grado.id = asignatura.id_grado WHERE grado.nombre = 'Grau en Enginyeria Informàtica (Pla 2015)';

SELECT DISTINCT * FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar WHERE anyo_inicio = 2018 AND anyo_fin = 2019;

SELECT departamento.nombre AS 'Nombre del departamento', persona.apellido1 AS 'Primer apellido', persona.apellido2 AS 'Segundo apellido', persona.nombre AS 'Nombre' FROM persona JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

SELECT * FROM persona JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;

SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_departamento IS NULL;

SELECT * FROM persona JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura  ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL;

SELECT * FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id_profesor IS NULL;

SELECT * FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id IS NULL;

SELECT count(persona.id) FROM persona WHERE persona.tipo = 'alumno';

SELECT count(persona.id) FROM persona  WHERE persona.tipo = 'alumno' AND YEAR(persona.fecha_nacimiento) = 1999;

SELECT departamento.nombre AS 'Nombre del departamento', COUNT(profesor.id_departamento) AS 'Numero de profesores' FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(profesor.id_departamento) DESC;

SELECT departamento.nombre, COUNT(profesor.id_profesor) FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre;

SELECT grado.nombre, COUNT(asignatura.id) FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.id) DESC;

SELECT grado.nombre, COUNT(asignatura.id) FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40;

SELECT grado.nombre AS 'Nombre del grado', asignatura.tipo AS 'Tipo de asignatura', SUM(asignatura.creditos) AS 'Total de céditos' FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;

SELECT curso_escolar.anyo_inicio AS 'Año de inicio', COUNT(DISTINCT persona.id) AS 'Numero de alumnos matriculados' FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id GROUP BY curso_escolar.anyo_inicio;

SELECT persona.id AS 'ID', persona.nombre AS 'Nombre', persona.apellido1 AS 'Primer apellido', persona.apellido2 AS 'Segundo apellido', COUNT(asignatura.id) AS 'Numero de asignaturas' FROM persona JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY persona.id ORDER BY COUNT(asignatura.id) DESC;

SELECT * FROM persona WHERE persona.tipo = 'alumno' AND persona.fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE persona.tipo = 'alumno');

SELECT * FROM profesor JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
