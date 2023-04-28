# Practica realizada en PgAdmin con Function, Procedure, Cursor y Trigger
### Belén Gamero Garcia y Edgar López Hernández

## Crear un proyecto en pgAdmin con PostgreSQL

1. Crear una base de datos:

```
CREATE DATABASE DB;
```

2. Cree una tabla para almacenar los datos:

```
CREATE TABLE usuarios (
  id INTEGER PRIMARY KEY,
  nombre VARCHAR(50),
  correo_electronico VARCHAR(50),
  edad INTEGER
);
```

3. Introduzca los datos de los usuarios de la tabla anterior:

```
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

```

4. Cree una función que calcule la edad promedio de los usuarios de la tabla:

```
CREATE FUNCTION calcular_edad_promedio()
RETURNS INTEGER AS $$
DECLARE
  edad_promedio INTEGER;
BEGIN
  SELECT AVG(edad) INTO edad_promedio FROM usuarios;
  RETURN edad_promedio;
END;
$$ LANGUAGE plpgsql;
```

![image](https://user-images.githubusercontent.com/91567318/234351671-642f4519-6cf4-443d-b325-6dccdcdc4425.png)


5. Cree un procedimiento almacenado que inserte un nuevo usuario en la tabla:

```
CREATE PROCEDURE insertar_usuario(nombre VARCHAR(50), correo_electronico VARCHAR(50), edad INTEGER)
AS $$
BEGIN
  INSERT INTO usuarios (nombre, correo_electronico, edad) VALUES (nombre, correo_electronico, edad);
END;
$$ LANGUAGE plpgsql;
```

![image](https://user-images.githubusercontent.com/91567318/234351594-1e569d09-6644-4bcd-bbd9-7a23d2e54aa7.png)


6. Cree un cursor que recorra todos los usuarios de la tabla y los muestre:

```
BEGIN;
DECLARE cursor_usuarios CURSOR FOR
SELECT nombre, correo_electronico, edad
FROM usuarios;
```

![image](https://user-images.githubusercontent.com/91567318/235225531-4a1ad1da-a14d-4cb3-97d4-9053945c359a.png)


7. Cree un trigger que se active cada vez que se inserte un nuevo usuario en la tabla y muestre un mensaje en la consola:

```
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
```
![image](https://user-images.githubusercontent.com/91567318/234352653-4b91b143-dfc5-473e-adf3-4f9849ed5eec.png)


## Pruebas

- Para llamar a la función de calcular la edad promedio de los usuarios:

```
SELECT calcular_edad_promedio();
```

![image](https://user-images.githubusercontent.com/91567318/235224100-ad9cea26-dbf7-45fe-aafe-c6bcd911d298.png)

- Para llamar al procedimiento almacenado de insertar un nuevo usuario:

```
CALL insertar_usuario ('Neus', 'Neus@example.com', 15);
```

![image](https://user-images.githubusercontent.com/91567318/235223926-a89e52e8-07a1-4b47-9402-9cdea096f424.png)

- Para llamar al cursor de mostrar todos los usuarios:

```
FETCH ALL IN cursor_usuarios;
```

![image](https://user-images.githubusercontent.com/91567318/235226366-ab81db2b-1de4-4f68-979e-169a4aeaf22c.png)

y para salir ponemos un commit

```
COMMIT;
```

![image](https://user-images.githubusercontent.com/91567318/235226729-ec43e54c-4923-49ee-9221-c4bc4e4b8879.png)

- Para insertar un nuevo usuario y activar el trigger:

```
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (15, 'Pedro', 'pedro@example.com', 25);
```

![image](https://user-images.githubusercontent.com/91567318/235226929-27235585-c787-4250-a5b1-e59b334906a0.png)



