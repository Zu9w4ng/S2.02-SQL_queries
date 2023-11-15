-- 1
SELECT nombre, apellido1, apellido2 FROM persona
WHERE tipo = 'alumno';

-- 2
SELECT nombre, apellido1, apellido2 FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3
SELECT * FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4
SELECT * FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5
SELECT * FROM asignatura
WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;

-- 6
SELECT persona.nombre, persona.apellido1, persona.apellido2, profesor.id_profesor, departamento.nombre
FROM (persona INNER JOIN profesor ON persona.id = profesor.id_profesor) LEFT JOIN departamento
ON profesor.id_departamento = departamento.id;

-- 7
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM (alumno_se_matricula_asignatura INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id)
INNER JOIN curso_escolar 
ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE alumno_se_matricula_asignatura.id_alumno = (SELECT id FROM persona WHERE nif = '26902806M');

-- 8
SELECT DISTINCT nombre
FROM departamento
WHERE id = (SELECT DISTINCT id_departamento FROM profesor
WHERE id_profesor IN (SELECT id_profesor FROM asignatura
WHERE id_grado = (SELECT id FROM grado
WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)')));

-- 9
SELECT * FROM persona
WHERE id IN (SELECT id_alumno FROM alumno_se_matricula_asignatura
WHERE id_curso_escolar = (SELECT id FROM curso_escolar
WHERE anyo_inicio = 2018 AND anyo_fin = 2019));

-- 1
SELECT persona.nombre, persona.apellido1, persona.apellido2, departamento.nombre
FROM (persona INNER JOIN profesor ON persona.id = profesor.id_profesor) LEFT JOIN departamento
ON profesor.id_departamento = departamento.id;

-- 2
SELECT persona.nombre, persona.apellido1, persona.apellido2, departamento.nombre
FROM (persona INNER JOIN profesor ON persona.id = profesor.id_profesor) LEFT JOIN departamento
ON profesor.id_departamento = departamento.id
WHERE departamento.nombre IS NULL;

-- 3
SELECT profesor.id_profesor, profesor.id_departamento, departamento.nombre
FROM profesor RIGHT JOIN departamento
ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

-- 4
SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
INNER JOIN (SELECT profesor.id_profesor, COUNT(asignatura.id) AS num FROM profesor LEFT JOIN asignatura
ON profesor.id_profesor = asignatura.id_profesor
GROUP BY profesor.id_profesor
HAVING num = 0) AS tabla
ON persona.id = tabla.id_profesor;

-- 5
SELECT asignatura.nombre
FROM asignatura LEFT JOIN profesor 
ON asignatura.id_profesor = profesor.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- 6
SELECT nombre
FROM departamento
WHERE id IN (SELECT profesor.id_departamento
	FROM profesor LEFT JOIN asignatura
	ON profesor.id_profesor = asignatura.id_profesor
	WHERE asignatura.id_profesor IS NULL) 
OR id NOT IN (SELECT id_departamento FROM profesor);

-- consultes resum
-- 1
SELECT COUNT(id) AS num_alumnos FROM persona
GROUP BY tipo
HAVING tipo = 'alumno';

-- 2
SELECT COUNT(id) AS num_alumnos FROM persona
WHERE YEAR(fecha_nacimiento) = 1999
GROUP BY tipo
HAVING tipo = 'alumno';

-- 3
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS num_profesores
FROM departamento INNER JOIN profesor
ON departamento.id = profesor.id_departamento
GROUP BY departamento.id
ORDER BY num_profesores DESC;

-- 4
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS num_profesores
FROM departamento LEFT JOIN profesor
ON departamento.id = profesor.id_departamento
GROUP BY departamento.id;

-- 5
SELECT grado.nombre, COUNT(asignatura.id) AS num_asignaturas
FROM grado LEFT JOIN asignatura
ON asignatura.id_grado = grado.id
GROUP BY grado.id
ORDER BY num_asignaturas DESC;

-- 6
SELECT grado.nombre, COUNT(asignatura.id) AS num_asignaturas
FROM grado LEFT JOIN asignatura
ON asignatura.id_grado = grado.id
GROUP BY grado.id
HAVING num_asignaturas > 40
ORDER BY num_asignaturas DESC;

-- 7
SELECT grado.nombre, asignatura.tipo, COUNT(asignatura.creditos) AS n_creditos
FROM grado LEFT JOIN asignatura
ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo;

-- 8
SELECT curso_escolar.anyo_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) AS n_alumnos
FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura
ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
GROUP BY curso_escolar.id;

-- 9
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS num_asignaturas
FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
GROUP BY persona.id
ORDER BY num_asignaturas DESC;

-- 10
SELECT * FROM persona
WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');

-- 11
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2
FROM persona INNER JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE profesor.id_departamento IS NOT NULL
GROUP BY persona.id
HAVING COUNT(asignatura.id) = 0;