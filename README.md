# 09_02_ASSI_function_procedure_cursor_trigger
### Belén Gamero Garcia y Edgar López Hernández

## Crear un proyecto en pgAdmin con PostgreSQL

1. Crear una base de datos:

```
CREATE DATABASE nombre_de_tu_base_de_datos;
```

2. Cree una tabla para almacenar los datos:

```
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  correo_electronico VARCHAR(50),
  edad INTEGER
);
```

3. Cree una función que calcule la edad promedio de los usuarios de la tabla:

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

4. Cree un procedimiento almacenado que inserte un nuevo usuario en la tabla:

```
CREATE PROCEDURE insertar_usuario(nombre VARCHAR(50), correo_electronico VARCHAR(50), edad INTEGER)
AS $$
BEGIN
  INSERT INTO usuarios (nombre, correo_electronico, edad) VALUES (nombre, correo_electronico, edad);
END;
$$ LANGUAGE plpgsql;
```

5. Cree un cursor que recorra todos los usuarios de la tabla y los muestre:

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

6. Cree un trigger que se active cada vez que se inserte un nuevo usuario en la tabla y muestre un mensaje en la consola:

```
CREATE TRIGGER mostrar_mensaje AFTER INSERT ON usuarios
FOR EACH ROW
EXECUTE FUNCTION mostrar_mensaje();
```
## Prueba
Para probar todo lo enterior utilize los siguientes comandos:

- Para llamar a la función de calcular la edad promedio de los usuarios:

```
SELECT calcular_edad_promedio();
```

- Para llamar al procedimiento almacenado de insertar un nuevo usuario:

```
CALL insertar_usuario('Juan', 'juan@example.com', 30);
```

- Para llamar al cursor de mostrar todos los usuarios:

```
SELECT mostrar_usuarios();
```

- Para insertar un nuevo usuario y activar el trigger:

```
INSERT INTO usuarios (nombre, correo_electronico, edad) VALUES ('Pedro', 'pedro@example.com', 25);
```

