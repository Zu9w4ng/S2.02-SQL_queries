-- 1
SELECT nombre FROM producto;

-- 2
SELECT nombre, precio FROM producto;

-- 3
SELECT * FROM producto;

-- 4
SELECT nombre, precio, precio*1.08 AS precioUSD FROM producto;

-- 5
SELECT nombre AS nom_de_producto, precio AS euros, precio*1.08 AS USD FROM producto;

-- 6
SELECT UPPER(nombre), precio FROM producto;

-- 7
SELECT LOWER(nombre), precio FROM producto;

-- 8
SELECT nombre, SUBSTRING(nombre, 1, 2) AS codigo_nombre FROM fabricante;

-- 9
SELECT nombre, ROUND(precio, 2) AS round_precio FROM producto;

-- 10
SELECT nombre, FLOOR(precio) AS trunc_precio FROM producto;

-- 11
SELECT fabricante.codigo, fabricante.nombre 
FROM fabricante 
INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- 12
SELECT DISTINCT fabricante.codigo, fabricante.nombre 
FROM fabricante 
INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- 13
SELECT nombre FROM fabricante ORDER BY nombre;

-- 14
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15
SELECT nombre, precio FROM producto ORDER BY nombre, precio DESC;

-- 16
SELECT * FROM fabricante LIMIT 5;

-- 17
SELECT * FROM fabricante LIMIT 3,2;

-- 18
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

-- 19
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre;

-- 23
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre
FROM producto LEFT JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo;

-- 24
SELECT producto.nombre, precio, fabricante.nombre AS nombre_fabricante
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio LIMIT 1;

-- 25
SELECT producto.nombre, precio, fabricante.nombre AS nombre_fabricante
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY precio DESC LIMIT 1;

-- 26
SELECT *
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

-- 27
SELECT *
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND precio > 200;

-- 28
SELECT *
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29
SELECT *
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30
SELECT producto.nombre, precio
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

-- 31
SELECT producto.nombre, precio
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

-- 32
SELECT producto.nombre, precio, fabricante.nombre
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >= 180
ORDER BY precio DESC, producto.nombre;

-- 33
SELECT DISTINCT fabricante.codigo, fabricante.nombre
FROM fabricante INNER JOIN producto
ON producto.codigo_fabricante = fabricante.codigo;

-- 34
SELECT *
FROM fabricante LEFT JOIN producto
ON producto.codigo_fabricante = fabricante.codigo;

-- 35
SELECT *
FROM fabricante LEFT JOIN producto
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.codigo_fabricante IS NULL;

-- 36
SELECT *
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

-- 37
SELECT MAX(precio) INTO @precio
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

SELECT * FROM producto
WHERE precio = @precio;

-- 38
SELECT producto.nombre
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY precio DESC LIMIT 1;

-- 39
SELECT producto.nombre
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY precio LIMIT 1;

-- 40
SELECT MAX(precio) INTO @precio
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

SELECT * FROM producto
WHERE precio >= @precio;

-- 41
SELECT AVG(precio) INTO @precioMedioAsus
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus';

SELECT * 
FROM producto LEFT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >= @precioMedioAsus AND fabricante.nombre = 'Asus';




