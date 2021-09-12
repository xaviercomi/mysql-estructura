SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 DESC, apellido2, nombre;
SELECT nombre, apellido1, apellido2, telefono FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = '1999';
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS Departamento FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_profesor = d.id ORDER BY d.nombre, apellido1, apellido2, nombre;
SELECT nombre, anyo_inicio, anyo_fin FROM asignatura a JOIN alumno_se_matricula_asignatura al ON a.id = al.id_asignatura JOIN curso_escolar ce ON al.id_curso_escolar = ce.id WHERE al.id_alumno = (SELECT id FROM persona WHERE nif = '26902806M');
SELECT d.nombre FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id_grado = (SELECT id FROM grado WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)') GROUP BY d.nombre;
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno WHERE id_curso_escolar = (SELECT id FROM curso_escolar WHERE anyo_inicio = '2018') GROUP BY p.nombre;

-- Consultes amb clàusules LEFT JOIN I RIGHT JOIN

SELECT pe.apellido1, pe.apellido2, pe.nombre, d.nombre FROM persona pe RIGHT JOIN profesor p ON pe.id = p.id_profesor LEFT JOIN departamento d ON p.id_departamento = d.id;
SELECT pe.apellido1, pe.apellido2, pe.nombre FROM persona pe RIGHT JOIN profesor p ON pe.id = p.id_profesor WHERE p.id_departamento IS NULL;
SELECT d.nombre FROM departamento d LEFT JOIN profesor P ON d.id = id_departamento WHERE id_profesor IS NULL;
SELECT pe.apellido1, pe.apellido2, pe.nombre FROM persona pe RIGHT JOIN profesor p ON pe.id = p.id_profesor LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id IS NULL;
SELECT nombre FROM asignatura WHERE id_profesor IS NULL;
SELECT d.nombre FROM departamento d;

-- Consultes resum

SELECT COUNT(id) AS 'numero de alumnos' FROM persona WHERE tipo = 'alumno';
SELECT COUNT(id) AS 'alumnos nacidos en 1999' FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = YEAR('1999');
SELECT COUNT(p.id_profesor) AS 'numero de profesores', d.nombre FROM profesor p RIGHT JOIN departamento d ON P.id_departamento = d.id  GROUP BY d.nombre;
SELECT g.nombre AS 'grado', a.tipo, SUM(a.creditos) AS 'cantidad de creditos' FROM grado g RIGHT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;
SELECT c.anyo_inicio AS 'año', SUM(a.id_alumno) AS 'numero de alumnos' FROM curso_escolar c LEFT JOIN alumno_se_matricula_asignatura a ON c.id = a.id_curso_escolar GROUP BY c.anyo_inicio;
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona) AND tipo = 'alumno';
SELECT p.id, p.nombre, p.apellido1, p.apellido2, d.nombre FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id AND pr.id_profesor = (SELECT id_profesor FROM asignatura WHERE id IS NULL);

  