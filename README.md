# 09_02_ASSI_function_procedure_cursor_trigger



Para crear un proyecto de PostgreSQL con una función, un procedimiento, un cursor y un trigger, podemos seguir los siguientes pasos:

1. Crear una base de datos en PostgreSQL:

```SQL
CREATE DATABASE proyecto_postgresql;
```

2. Conectarse a la base de datos:

```SQL
\c proyecto_postgresql;
```

3. Crear una tabla llamada "ventas" para nuestro proyecto:

```SQL
CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    producto VARCHAR(50),
    cantidad INTEGER,
    precio NUMERIC(10,2),
    fecha DATE
);
```

4. Insertar algunos datos de muestra en la tabla "ventas":

```SQL
INSERT INTO ventas (producto, cantidad, precio, fecha) VALUES
    ('Producto A', 10, 100.50, '2022-01-01'),
    ('Producto B', 5, 50.25, '2022-01-02'),
    ('Producto C', 20, 10.75, '2022-01-03');
```

5. Crear una función llamada "calcular_total" que calcule el total de ventas por producto:

```SQL
CREATE OR REPLACE FUNCTION calcular_total() RETURNS TABLE (
    producto VARCHAR(50),
    total NUMERIC(10,2)
) AS $$
BEGIN
    RETURN QUERY SELECT producto, SUM(cantidad * precio) AS total FROM ventas GROUP BY producto;
END;
$$ LANGUAGE plpgsql;
```

6. Crear un procedimiento llamado "insertar_venta" que inserte una nueva venta en la tabla "ventas":

```SQL
CREATE OR REPLACE PROCEDURE insertar_venta(
    p_producto VARCHAR(50),
    p_cantidad INTEGER,
    p_precio NUMERIC(10,2),
    p_fecha DATE
) AS $$
BEGIN
    INSERT INTO ventas (producto, cantidad, precio, fecha) VALUES (p_producto, p_cantidad, p_precio, p_fecha);
END;
$$ LANGUAGE plpgsql;
```

7. Crear un cursor llamado "ventas_cursor" que recorra todas las ventas y las muestre por pantalla:

```SQL
CREATE OR REPLACE FUNCTION mostrar_ventas() RETURNS VOID AS $$
DECLARE
    r_venta ventas%ROWTYPE;
    c_ventas CURSOR FOR SELECT * FROM ventas;
BEGIN
    OPEN c_ventas;
    LOOP
        FETCH c_ventas INTO r_venta;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Venta #%: Producto: %, Cantidad: %, Precio: %, Fecha: %', r_venta.id, r_venta.producto, r_venta.cantidad, r_venta.precio, r_venta.fecha;
    END LOOP;
    CLOSE c_ventas;
END;
$$ LANGUAGE plpgsql;
```

8. Crear un trigger llamado "actualizar_total" que se active cada vez que se inserte o actualice una venta, y actualice el total de ventas por producto en una tabla llamada "totales_ventas":

```SQL
CREATE OR REPLACE FUNCTION actualizar_total() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM totales_ventas WHERE producto = NEW.producto;
    INSERT INTO totales_ventas (producto, total) SELECT producto, SUM(cantidad * precio) AS total FROM ventas WHERE producto = NEW.producto GROUP BY producto;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_total AFTER INSERT OR UPDATE ON ventas FOR EACH ROW EXECUTE FUNCTION actualizar_total();
```

Con estos pasos, hemos creado un proyecto de PostgreSQL que incluye una función, un procedimiento, un cursor y un trigger que nos permiten gestionar ventas y calcular el total de ventas por producto.

