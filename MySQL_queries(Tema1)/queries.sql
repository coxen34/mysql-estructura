SELECT nombre FROM producto;
SELECT nombre,precio FROM producto;
SELECT * FROM producto;
SELECT nombre , precio , ROUND (precio * 1.10,2) FROM producto;
SELECT nombre AS nombre_producto, precio AS precio_euros, ROUND (precio * 1.10,2) AS precio_dolares_norte_americanos 
SELECT UPPER(nombre) productos,precio FROM producto;
SELECT LOWER(nombre) productos,precio FROM producto;
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) FROM fabricante;
SELECT nombre,ROUND(precio) FROM producto;
SELECT nombre,TRUNCATE(precio,0) FROM producto;
SELECT codigo_fabricante FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante);
SELECT distinct(codigo_fabricante) FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante);
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre FROM producto ORDER BY nombre ASC,precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre,precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante=2;
SELECT p.nombre, p.precio,f.nombre AS nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo;
SELECT p.nombre, p.precio,f.nombre AS nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY f.nombre ASC;
SELECT p.codigo AS codigo_producto,p.nombre AS nombre_producto,f.codigo AS codigo_fabricante,f.nombre AS nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo;
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT MIN(precio) FROM producto);
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT MAX(precio) FROM producto);
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre='Lenovo';
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre='Crucial' AND p.precio>200;
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre='Asus' OR f.nombre='Hewlett-Packard' OR f.nombre='Seagate';
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre IN ('Asus','Hewlett-Packard','Seagate');
SELECT p.nombre,p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre LIKE('%e');
SELECT p.nombre,p.precio FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre LIKE('%w%');
SELECT p.nombre,p.precio,f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE p.precio>=180 ORDER BY p.precio DESC,f.nombre ASC;
SELECT f.codigo, f.nombre FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante GROUP BY f.codigo;
SELECT f.nombre ,p.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo=p.codigo_fabricante;
SELECT f.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo=p.codigo_fabricante WHERE p.nombre is NULL;
SELECT nombre FROM producto WHERE codigo_fabricante=(SELECT codigo FROM fabricante f WHERE nombre LIKE('Lenovo'));
SELECT * FROM producto WHERE precio = (SELECT MAX(precio)FROM producto WHERE codigo = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
SELECT p.nombre FROM producto p WHERE p.precio = (SELECT MAX(precio)FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
SELECT p.nombre FROM producto p WHERE p.precio = (SELECT MIN(precio)FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard'));
SELECT p.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE p.precio >= (SELECT MAX(precio)FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));
SELECT p.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo WHERE p.precio > (SELECT AVG(precio)FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'))AND f.nombre LIKE 'Asus';
SELECT p.apellido1,p.apellido2,p.nombre FROM persona p WHERE tipo LIKE('alumno')ORDER BY p.apellido1 ASC,p.apellido2 ASC,p.nombre ASC;
SELECT p.nombre,p.apellido1,p.apellido2 FROM persona p WHERE tipo LIKE('alumno') AND telefono IS NULL;
SELECT * FROM persona p WHERE YEAR(fecha_nacimiento)= 1999;
SELECT * FROM persona p WHERE tipo LIKE('profesor') AND telefono IS NULL AND nif LIKE('%K');
SELECT a.nombre FROM asignatura a INNER JOIN grado g ON a.id_grado = g.id INNER JOIN curso_escolar ce ON a.curso = ce.id WHERE g.id = 7 AND a.cuatrimestre = 1 AND a.curso = 3;
SELECT p.apellido1,p.apellido2,p.nombre,d.nombre FROM persona p INNER JOIN profesor prof ON prof.id_profesor=p.id INNER JOIN departamento d ON prof.id_departamento=d.id WHERE p.tipo LIKE('profesor') ORDER BY p.apellido1 ASC,p.apellido2 ASC,p.nombre ASC;
SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura am INNER JOIN asignatura a ON am.id_asignatura = a.id INNER JOIN curso_escolar c ON am.id_curso_escolar = c.id INNER JOIN persona p ON am.id_alumno = p.id WHERE p.nif = '26902806M';
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d INNER JOIN profesor p ON d.id = p.id_departamento INNER JOIN asignatura a ON p.id_profesor = a.id_profesor INNER JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
SELECT DISTINCT p.nombre FROM persona p INNER JOIN alumno_se_matricula_asignatura am ON p.id=am.id_alumno INNER JOIN curso_escolar ce ON am.id_curso_escolar=ce.id WHERE ce.anyo_inicio=2018 AND ce.anyo_fin=2019;
SELECT d.nombre AS nombre_departamento , p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN departamento d ON p.id = d.id LEFT JOIN profesor pr ON p.id = pr.id_profesor ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_departamento LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE d.nombre IS NULL ;
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr  ON d.id= pr.id_departamento WHERE pr.id_profesor IS NULL ;
SELECT p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL OR pr.id_profesor IS NULL;
SELECT a.nombre,a.id FROM asignatura a LEFT JOIN persona p ON a.id_profesor=p.id WHERE a.id_profesor IS NULL;
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr  ON d.id=pr.id_departamento WHERE pr.id_departamento IS NULL;
SELECT COUNT(p.nombre)FROM persona p WHERE p.tipo LIKE('alumno');
SELECT COUNT(p.nombre)FROM persona p WHERE p.tipo =('alumno') AND YEAR(p.fecha_nacimiento)=1999;
SELECT d.nombre AS nom_departament, COUNT(pr.id_profesor) AS nombre_professors FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento INNER JOIN persona p ON d.id = p.id GROUP BY d.id, d.nombre ORDER BY nombre_professors DESC, p.nombre DESC;
SELECT d.nombre AS nom_departament,COUNT(pr.id_profesor) AS nombre_professors FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento GROUP BY d.id;
SELECT g.nombre AS nombre_grado, a.nombre FROM grado g LEFT JOIN asignatura a ON g.id=a.id_grado GROUP BY g.id,a.nombre ORDER BY a.nombre DESC;
SELECT g.nombre AS nombre_grado,COUNT(a.id)FROM grado g LEFT JOIN asignatura a ON g.id=a.id_grado WHERE COUNT(a.id)=(SELECT COUNT(a.id)FROM asignatura a WHERE COUNT(a.id) >40);
--
--
--
SELECT * FROM persona p WHERE tipo LIKE('alumno') ORDER BY TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) ASC LIMIT 1;
--