--Crear tablas

CREATE TABLE IF NOT EXISTS Cervezas(
CodC int(2) PRIMARY KEY,
Envase VARCHAR(255),
Capacidad double(2),
Stock int(3)
)

CREATE TABLE EQUIPO(
CODIGO INT (2) PRIMARY KEY, 
NOMBRE VARCHAR(255),
ANIO_FUNDACION INT(4) 
)

CREATE TABLE IF NOT EXISTS BARES (
Codb int(2) PRIMARY KEY,
CIF VARCHAR(9),
Nombre VARCHAR(255),
Localidad VARCHAR(255)
)

CREATE TABLE EMPLEADOS (
CodE INT (2) PRIMARY KEY,
Nombre VARCHAR(255),
Sueldo INT (3)
)

CREATE TABLE Reparto (
CodE INT,
Codb INT,
CodC INT,
Fecha DATE,
Cantidad INT (3),
FOREIGN KEY (CodE) REFERENCES EMPLEADOS (CodE),
FOREIGN KEY (Codb) REFERENCES BARES (Codb),
FOREIGN KEY (CodC) REFERENCES Cervezas(CodC)
)

--Introducir Datos (Claude provee, para eso fue creado, automatizar tareas que los humanos no quieren hacer)

INSERT INTO Cervezas (CodC, Envase, Capacidad, Stock) VALUES
(1, 'Botella', 0.2, 3600),
(2, 'Botella', 0.33, 1200),
(3, 'Lata', 0.33, 2400),
(4, 'Botella', 1, 288),
(5, 'Barril', 60, 30);

INSERT INTO BARES (Codb, CIF, Nombre, Localidad) VALUES
(1, '11111111X', 'Stop', 'Villa Botijo'),
(2, '22222222Y', 'Las Vegas', 'Villa Botijo'),
(3, '-', 'Club Social', 'Las Ranas'),
(4, '33333333Z', 'Otra Ronda', 'La Esponja');

INSERT INTO EMPLEADOS (CodE, Nombre, Sueldo) VALUES
(1, 'Prudencio Caminero', 120000),
(2, 'Vicente Merario', 110000),
(3, 'Valentin Siempre', 100000);

INSERT INTO Reparto (CodE, Codb, CodC, Fecha, Cantidad) VALUES
(1, 1, 1, '10/21/05', 240),
(1, 1, 2, '10/21/05', 48),
(1, 2, 3, '10/22/05', 60),
(1, 4, 5, '10/22/05', 4),
(2, 2, 3, '10/22/05', 48),
(2, 2, 5, '10/23/05', 2),
(2, 4, 1, '10/23/05', 480),
(2, 4, 2, '10/24/05', 72),
(3, 3, 3, '10/24/05', 48),
(3, 3, 4, '10/25/05', 20);

---Ejercicios

---1
SELECT DISTINCT e.Nombre FROM EMPLEADOS e
JOIN Reparto r ON e.CodE = r.CodE
JOIN BARES b ON b.Codb = r.Codb
WHERE b.Nombre = 'Stop' AND R.Fecha BETWEEN '10/17/05' AND '10/23/05';

---2

SELECT DISTINCT b.CIF, b.Nombre, b.Localidad FROM BARES b
JOIN Reparto r ON b.Codb = r.Codb
JOIN Cervezas c ON c.CodC = r.CodC
WHERE c.Envase = 'Botella' AND Capacidad < 1 ORDER BY b.Localidad;

---3

SELECT r.Fecha, r.Cantidad, b.Nombre, c.Envase, c.Capacidad FROM Reparto r
JOIN EMPLEADOS e ON e.Code = r.Code
JOIN Cervezas c ON c.CodC = r.CodC
JOIN BARES b ON b.Codb = r.Codb
WHERE e.Nombre = "Prudencio Caminero";

---4

SELECT b.Nombre, b.Localidad FROM BARES b 
JOIN Reparto r ON r.Codb = b.Codb
JOIN CERVEZAS c ON c.CodC = r.CodC
WHERE c.Envase = 'Botella' AND (c.Capacidad = 0.2 OR c.Capacidad = 0.33)
GROUP BY b.Nombre, b.Localidad


---5

SELECT e.Nombre FROM EMPLEADOS e
JOIN Reparto r  ON r.CodE = e.CodE
JOIN BARES b  ON b.Codb = r.Codb
JOIN Cervezas c ON c.CodC = r.CodC
WHERE b.Nombre IN ('Stop', 'Las Vegas') AND c.Envase = 'Botella'
GROUP BY e.Nombre
HAVING COUNT(DISTINCT b.Nombre) = 2;

---6

SELECT e.Nombre, COUNT(r.Fecha) AS 'Número de viajes' FROM Reparto r
JOIN EMPLEADOS e ON r.CodE = e.CodE
JOIN BARES b ON b.Codb = r.Codb
WHERE b.Localidad != 'Villa Botijo'
GROUP BY e.Nombre;

---7

SELECT b.Nombre, b.Localidad, SUM(r.Cantidad * c.Capacidad) AS 'Litros de cerveza comprados' FROM BARES b
JOIN Reparto r ON b.Codb = r.Codb
JOIN CERVEZAS c ON r.CodC = c.CodC
GROUP BY b.Nombre, b.Localidad
ORDER BY SUM(r.Cantidad * c.Capacidad) DESC 
LIMIT 1

--- 8 

SELECT b.Nombre, b.Localidad FROM BARES b
JOIN Reparto r  ON r.Codb = b.Codb
JOIN Cervezas c ON c.CodC = r.CodC
WHERE c.Envase = 'Botella' AND c.Capacidad < 1
GROUP BY b.Codb
HAVING COUNT(DISTINCT c.CodC) = (
    SELECT COUNT(*) FROM Cervezas WHERE Envase = 'Botella' AND Capacidad < 1
);


--- 9

UPDATE EMPLEADOS
SET Sueldo = Sueldo * 1.05
WHERE Nombre = ( SELECT e.Nombre FROM EMPLEADOS e JOIN Reparto r ON r.CodE = e.CodE GROUP BY e.CodE ORDER BY COUNT(DISTINCT r.Fecha) DESC LIMIT 1
);

--- 10

INSERT INTO Reparto (CodE, Codb, CodC, Fecha, Cantidad)
VALUES ((SELECT e.CodE FROM Empleados e WHERE e.Nombre = 'Vicente Merario'), (SELECT b.Codb FROM BARES b WHERE b.Nombre = 'Stop'), (SELECT c.Codc FROM CERVEZAS c WHERE c.Envase = 'Lata'), '10/26/05', 48)






