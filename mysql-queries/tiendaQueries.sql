SELECT * FROM producto;
SELECT nombre, precio FROM producto;
SHOW COLUMNS FROM producto;
SELECT nombre, precio, (precio * 118) /100; 
SELECT nombre AS 'nom de producto', precio AS 'euros', (precio * 118) /100 AS 'dolars' FROM producto;
SELECT UCASE(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre AS 'Nombre fabricante', upper(left(nombre,2)) AS 'ID' FROM fabricante;
SELECT nombre, ROUND(precio) AS 'Precio redondeado' FROM producto;
SELECT nombre, TRUNCATE(precio,2) AS 'Precio sin decimales' FROM producto;
SELECT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante GROUP BY codigo;
SELECT nombre FROM fabricante ORDER BY nombre;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, 	precio FROM producto ORDER BY nombre, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC limit 1;
SELECT nombre, codigo, codigo_fabricante FROM producto WHERE codigo_fabricante = 2;
SELECT p.nombre AS 'Nombre producto', p.precio, f.nombre AS 'Nombre fabricante' FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre AS 'Nombre producto', p.precio, f.nombre AS 'Nombre fabricante' FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;
SELECT p.nombre AS 'Nombre producto', p.precio, f.codigo AS 'Codigo fabricante', f.nombre AS 'Nombre fabricante' FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre AS 'Nombre producto', MIN(precio) AS 'Precio mas barato', f.nombre AS 'Nombre fabricante' FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo GROUP BY p.codigo ORDER BY MIN(precio) LIMIT 1;
SELECT p.nombre AS 'Nombre producto', MAX(precio) AS 'Precio mas caro', f.nombre AS 'Nombre fabricante' FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo GROUP BY p.codigo ORDER BY MAX(precio) DESC LIMIT 1;
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND p.precio > 200;
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus','Hewlett-Packard','Seagate');
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%';
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, f.nombre ASC;
SELECT f.codigo, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante GROUP BY f.codigo; 
SELECT f.codigo, f.nombre, p.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.codigo, f.nombre  FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
SELECT nombre, precio FROM producto WHERE precio = (SELECT MAX(precio) WHERE codigo_fabricante) = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
SELECT nombre, precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') LIMIT 1;
SELECT nombre, precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio LIMIT 1;
SELECT nombre, precio FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = 'Lenovo'); 
SELECT nombre, precio FROM producto WHERE precio > (SELECT AVG(precio) FROM producto) AND codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus');











