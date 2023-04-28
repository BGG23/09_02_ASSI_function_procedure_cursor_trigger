# 09_02_ASSI_function_procedure_cursor_trigger
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
CREATE PROCEDURE insertar_usuario(id INTEGER, nombre VARCHAR(50), correo_electronico VARCHAR(50), edad INTEGER)
AS $$
BEGIN
  INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (id, nombre, correo_electronico, edad);
END;
$$ LANGUAGE plpgsql;
```

![image](https://user-images.githubusercontent.com/91567318/234351594-1e569d09-6644-4bcd-bbd9-7a23d2e54aa7.png)


6. Cree un cursor que recorra todos los usuarios de la tabla y los muestre:

```
CREATE OR REPLACE FUNCTION mostrar_usuarios()
RETURNS VOID AS $$
DECLARE
  usuario usuarios%ROWTYPE;
  cursor_usuarios CURSOR FOR SELECT * FROM usuarios;
BEGIN
  OPEN cursor_usuarios;
  LOOP
    FETCH cursor_usuarios INTO usuario;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE 'Usuario %: %, % años', usuario.id, usuario.nombre, usuario.edad;
  END LOOP;
  CLOSE cursor_usuarios;
END;
$$ LANGUAGE plpgsql;
```

![image](https://user-images.githubusercontent.com/91567318/234351782-4dc7e720-476a-44ff-85c6-243d81abd609.png)


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

- Para llamar al procedimiento almacenado de insertar un nuevo usuario:

```
CALL insertar_usuario(1, 'Juan', 'juan@example.com', 30);
```

- Para llamar al cursor de mostrar todos los usuarios:

```
SELECT mostrar_usuarios();
```

- Para insertar un nuevo usuario y activar el trigger:

```
INSERT INTO usuarios (id, nombre, correo_electronico, edad) VALUES (15, 'Pedro', 'pedro@example.com', 25);
```
