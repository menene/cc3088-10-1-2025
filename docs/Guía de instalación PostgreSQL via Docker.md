# Configuración de PostgreSQL 16 con Docker en Puerto Alternativo

## Archivo `docker-compose.yml`
Si ya tienes otra versión de PostgreSQL corriendo en el puerto 5433, puedes utilizar el siguiente `docker-compose.yml` para levantar una nueva instancia en un puerto diferente, como el **5434**:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16
    container_name: postgres_db
    ports:
      - "5434:5432"
    environment:
      POSTGRES_USER: usuario
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: mi_base_de_datos
    volumes:
      - postgres_data_alt:/var/lib/postgresql/data

volumes:
  postgres_data_alt:
```

## Levantar el Contenedor
Para iniciar PostgreSQL en el nuevo puerto, navega hasta la carpeta donde está el archivo `docker-compose.yml` y ejecuta:

```sh
docker-compose up -d
```

## Restablecer la Contraseña Manualmente
Si encuentras problemas al autenticarte, puedes restablecer la contraseña directamente en PostgreSQL dentro del contenedor:

1. Accede al contenedor:

```sh
docker exec -it postgres_db psql -U postgres
```

2. Cambia la contraseña manualmente:

```sql
ALTER USER usuario WITH PASSWORD 'secret';
```

3. Sal de `psql` con:

```sql
\q
```

4. Reinicia el contenedor:

```sh
docker restart postgres_db
```

## Conexión desde una Herramienta Externa
Para conectarte a PostgreSQL desde un cliente como **pgAdmin, DBeaver, DataGrip o cualquier otro cliente SQL**, usa la siguiente configuración:

- **Host**: `localhost`
- **Puerto**: `5434`
- **Usuario**: `usuario`
- **Contraseña**: `secret`
- **Base de datos**: `mi_base_de_datos`

Si PostgreSQL está corriendo en un contenedor de Docker y necesitas conectarte desde otro contenedor dentro de la misma red de Docker, usa:

- **Host**: `postgres_db`
- **Puerto**: `5432`
- **Usuario**: `usuario`
- **Contraseña**: `secret`
- **Base de datos**: `mi_base_de_datos`

## Verificar la Conexión
Si deseas probar la conexión desde la línea de comandos, puedes ejecutar:

```sh
docker exec -it postgres_db psql -U usuario -d mi_base_de_datos
```

Para salir de la sesión de PostgreSQL:

```sql
\q
```

Ahora puedes gestionar tu base de datos con cualquier herramienta externa sin conflictos con la otra versión de PostgreSQL corriendo en el puerto 5433.

