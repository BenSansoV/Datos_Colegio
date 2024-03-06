USE colegio;
-- //Consultas simples//--
-- Query 1
-- Seleccionar todos los datos de la tabla Alumno
SELECT*
FROM alumno;

-- Query 2
-- Seleccionar todos los datos de la tabla Asignatura
SELECT*
FROM asignatura;

-- Query 3
-- Seleccionar todos los datos de la tabla Clase
SELECT*
FROM clase;

-- Query 4
-- Seleccionar todos los datos de la tabla Comuna
SELECT*
FROM comuna;

-- Query 5
-- Seleccionar todos los datos de la tabla Curso
SELECT*
FROM curso;

-- Query 6
-- Seleccionar todos los datos de la tabla Profesor
SELECT*
FROM profesor;

-- Query 7
-- Seleccionar a los alumnos de apellidos que comienzan con R
SELECT*
FROM alumno
WHERE Apellido LIKE 'R%';

-- Query 8
-- Seleccionar a los alumnos de apellidos que comienzan con R y nombre termine con O
SELECT*
FROM alumno
WHERE Apellido LIKE 'R%' and Nombre LIKE '%o';

-- Query 9
-- Seleccionar a los profesores de Lenguaje (2), Historia (4) e Inglés (7)
SELECT*
FROM profesor
WHERE ID_Asignatura IN(2,4,7);

-- Query 10
-- Seleccionar a todos los profesores excepto de las asignaturas Lenguaje (2) e Inglés (7)
SELECT*
FROM profesor
WHERE NOT ID_Asignatura IN(2,7);

-- Query 11
/* Seleccionar a los alumnos nacidos entre los años 80 y 90, mostrando nombre, apellido y fecha 
de nacimiento
Ordenados por fecha ascendente */
SELECT Nombre, Apellido, Fecha_Nac
FROM alumno
WHERE Fecha_Nac BETWEEN '1980-01-01' AND '1990-12-31'
ORDER BY Fecha_Nac ASC;

-- Query 12
/* Seleccionar a los alumnos de los cursos "B"(2,4,6,8) que tengan información en su dirección
Mostrando nombre, apellido, dirección, comuna y curso del alumno
ordenados por ID curso descendente */
SELECT Nombre,Apellido,Direccion,ID_Comuna,ID_Curso
FROM alumno
WHERE ID_Curso IN (2,4,6,8) AND Direccion IS NOT NULL
ORDER BY ID_Curso DESC;

-- Query 13
/* Seleccionar a los alumnos de los cursos 1°A (1) y 2°A (3) que no tengan dirección
-- Mostrando nombre, apellido, dirección y comuna del alumno */
SELECT Nombre,Apellido,Direccion,ID_Comuna
FROM alumno
WHERE ID_Curso IN (1,3) AND Direccion IS NULL;

-- //JOIN Y LEFT JOIN//
-- Query 14
/* Seleccionar cuantos alumnos hay en cada curso, 
sólo mostrando el nombre del curso y su cantidad de alumnos */
SELECT C.Nombre AS Nombre, COUNT(A.ID_Curso) AS Contador
FROM curso C
INNER JOIN Alumno A ON A.ID_Curso=C.ID
GROUP BY C.Nombre;

-- Query 15
-- Seleccionar Profesores que no han tenido clases con algún curso
SELECT P.*, C.ID, C.ID_Profesor, C.ID_Alumno
FROM profesor P
LEFT JOIN Clase C ON C.ID_Profesor = P.ID
WHERE C.ID_Profesor IS NULL;

-- Query 16
/* Seleccionar a los alumnos mostrando Apellido, Nombre y curso (con su nombre)
Solamente de los cursos A, excepto el 1 A
Poner Alias a la columna del Curso para que no aparezca como "Nombre"
Ordenar por Curso, luego por Apellido del Alumno ambos ascendentes */
SELECT A.Apellido, A.Nombre, C.Nombre AS Curso
FROM alumno A
JOIN curso C ON C.ID=A.ID_Curso
WHERE C.Nombre IN ('2 A','3 A','4 A')
ORDER BY C.Nombre ASC, A.Apellido ASC, A.Nombre ASC;

-- Query 17
/* Seleccionar el nombre, el apellido, la asignatura (como nombre), 
la dirección y comuna (como nombre) de los Profesores 
pero debe mostrar todos los profesores, aunque no tengan dirección
Poner alias a las columnas de comuna y asignatura */
SELECT P.Nombre, P.Apellido, A.Nombre AS Asignatura, P.Direccion, C.Nombre AS Comuna
FROM profesor P
LEFT JOIN comuna C ON C.ID=P.ID_Comuna
LEFT JOIN asignatura A ON A.ID=P.ID_Asignatura;

-- // SUBCONSULTAS // --
-- Query 18
/* Seleccionar a los alumnos mostrando Apellido, Nombre y curso (con su nombre)
Ordenar por ID Curso, luego por Apellido del Alumno ambos ascendentes*/
SELECT A.Apellido, A.Nombre, (SELECT C.Nombre FROM curso C WHERE C.ID=A.ID_Curso) as Curso
FROM alumno A
ORDER BY Curso ASC, A.Apellido ASC, A.Nombre ASC;
