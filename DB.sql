CREATE DATABASE DB;

CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY,
  nombre VARCHAR(50),
  correo_electronico VARCHAR(50),
  edad INTEGER
);

-- INSERT

INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (1, 'Juan', 'juan@example.com', 30);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (2, 'Ana', 'ana@example.com', 25);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (3, 'Pedro', 'pedro@example.com', 35);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (4, 'María', 'maria@example.com', 28);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (5, 'Luis', 'luis@example.com', 32);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (6, 'Sofía', 'sofia@example.com', 21);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (7, 'Daniel', 'daniel@example.com', 27);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (8, 'Carla', 'carla@example.com', 29);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (9, 'Andrés', 'andres@example.com', 31);
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (10, 'Marta', 'marta@example.com', 26);

-- FUNCTION

CREATE FUNCTION calcular_edad_promedio()
RETURNS INTEGER AS $$
DECLARE
  edad_promedio INTEGER;
BEGIN
  SELECT AVG(edad) INTO edad_promedio FROM usuarios;
  RETURN edad_promedio;
END;
$$ LANGUAGE plpgsql;

-- PROCEDURE

CREATE PROCEDURE insertar_usuario(nombre VARCHAR(50), correo_electronico VARCHAR(50), edad INTEGER)
AS $$
BEGIN
  INSERT INTO usuarios (nombre, correo_electronico, edad) VALUES (nombre, correo_electronico, edad);
END;
$$ LANGUAGE plpgsql;

-- CURSOR

BEGIN;
DECLARE cursor_usuarios CURSOR FOR
SELECT nombre, correo_electronico, edad
FROM usuarios;

-- TRIGGER

CREATE OR REPLACE FUNCTION mostrar_mensaje() 
RETURNS TRIGGER AS $$
BEGIN
  RAISE NOTICE 'Se ha insertado un nuevo usuario con id %', NEW.id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER nuevo_usuario 
AFTER INSERT ON usuarios 
FOR EACH ROW 
EXECUTE FUNCTION mostrar_mensaje();

