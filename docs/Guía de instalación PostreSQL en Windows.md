# Guía de Instalación y Configuración de PostgreSQL 16 en Windows

## Prerrequisitos
Antes de comenzar, descarga el instalador oficial de PostgreSQL 16 desde el siguiente enlace:

[https://www.enterprisedb.com/downloads/postgres-postgresql-downloads](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)

## Instalación de PostgreSQL 16
1. Ejecuta el instalador descargado.
2. En la pantalla de bienvenida, haz clic en "Next".
3. Selecciona el directorio de instalación y presiona "Next".
4. Selecciona los componentes que deseas instalar (por defecto se recomienda incluir PostgreSQL Server, pgAdmin y Stack Builder).
5. Especifica la carpeta de datos donde se almacenarán las bases de datos y haz clic en "Next".
6. Configura la contraseña para el usuario `postgres` y guárdala en un lugar seguro.
7. Define el puerto (por defecto `5432`) y presiona "Next".
8. Selecciona la configuración regional "Default Locale" y finaliza la instalación.

## Iniciar y Administrar el Servicio de PostgreSQL
Para iniciar el servidor de PostgreSQL, sigue estos pasos:

1. Abre el "Administrador de Servicios" de Windows (`services.msc`).
2. Busca el servicio `PostgreSQL 16` y haz clic en "Iniciar".

Para detener o reiniciar el servicio, puedes hacer clic derecho en el servicio y seleccionar la acción correspondiente.

## Configuración Inicial
### Acceder a la Consola de PostgreSQL
Después de la instalación, puedes acceder a la consola ejecutando:

1. Abre el "Símbolo del sistema" (`cmd`).
2. Ejecuta el siguiente comando:

```sh
psql -U postgres
```

Ingresa la contraseña configurada durante la instalación.

### Crear un Nuevo Usuario y Base de Datos
Una vez dentro de `psql`, puedes crear un nuevo usuario:

```sql
CREATE USER tu_usuario WITH SUPERUSER CREATEDB CREATEROLE PASSWORD 'tu_contraseña';
```

Para crear una nueva base de datos:

```sql
CREATE DATABASE mi_base_de_datos OWNER tu_usuario;
```

Salir de `psql` con:

```sql
\q
```

### Configurar Autenticación
Si necesitas cambiar la autenticación, edita el archivo `pg_hba.conf`:

1. Navega hasta la ubicación del archivo de configuración (normalmente en `C:\Program Files\PostgreSQL\16\data\pg_hba.conf`).
2. Abre el archivo con un editor de texto y cambia la autenticación a `md5` para permitir acceso con contraseña:

```
host    all             all             127.0.0.1/32            md5
```

3. Guarda los cambios y reinicia el servicio de PostgreSQL.

## Verificar la Instalación
Para asegurarte de que PostgreSQL está funcionando correctamente, puedes ejecutar:

```sh
pg_isready
```

Si ves una salida similar a `localhost:5432 - accepting connections`, significa que PostgreSQL está funcionando correctamente.

Para listar las bases de datos disponibles:

```sh
psql -U tu_usuario -l
```

## Desinstalación
Si en algún momento deseas desinstalar PostgreSQL 16:

1. Ve al "Panel de Control" > "Programas y características".
2. Busca `PostgreSQL 16`, selecciona y haz clic en "Desinstalar".
3. Elimina manualmente la carpeta de datos si deseas remover completamente la instalación.

## Conclusión
Ahora tienes PostgreSQL 16 instalado y configurado en Windows. Puedes usar `pgAdmin` para administrar gráficamente tus bases de datos o conectarte desde cualquier cliente SQL compatible.

Para más configuraciones avanzadas, revisa la documentación oficial en [https://www.postgresql.org/docs/16/](https://www.postgresql.org/docs/16/).

