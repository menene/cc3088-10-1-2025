# Guía de Instalación y Configuración de PostgreSQL 16 en macOS usando Homebrew

## Prerrequisitos
Antes de comenzar, asegúrate de tener instalado [Homebrew](https://brew.sh/). Si no lo tienes, puedes instalarlo ejecutando:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Instalación de PostgreSQL 16
Ejecuta el siguiente comando en la terminal para instalar PostgreSQL 16:

```sh
brew install postgresql@16
```

Una vez instalado, agrega PostgreSQL 16 al PATH ejecutando:

```sh
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Si usas `bash`, reemplaza `~/.zshrc` por `~/.bash_profile`.

## Iniciar el Servicio de PostgreSQL
Para iniciar PostgreSQL como un servicio en segundo plano, usa:

```sh
brew services start postgresql@16
```

Para detener el servicio en cualquier momento:

```sh
brew services stop postgresql@16
```

Si prefieres iniciarlo manualmente sin usar `brew services`:

```sh
pg_ctl -D /opt/homebrew/var/postgresql@16 start
```

## Configuración Inicial
### Crear un Usuario y Base de Datos
PostgreSQL crea por defecto un usuario con el mismo nombre que el usuario del sistema. Para verificar la instalación, accede a la consola de PostgreSQL ejecutando:

```sh
psql postgres
```

Para crear un nuevo usuario con permisos de superusuario:

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
Para modificar la configuración de autenticación, edita el archivo `pg_hba.conf`:

```sh
nano /opt/homebrew/var/postgresql@16/pg_hba.conf
```

Modifica la línea de autenticación para que use contraseña en lugar de `peer`:

```
host    all             all             127.0.0.1/32            md5
```

Guarda los cambios y reinicia el servicio:

```sh
brew services restart postgresql@16
```

## Verificar la Instalación
Para confirmar que PostgreSQL está corriendo, ejecuta:

```sh
pg_isready
```

Si ves una salida como `postgresql@16:5432 - accepting connections`, significa que PostgreSQL está funcionando correctamente.

Para listar las bases de datos disponibles:

```sh
psql -U tu_usuario -l
```

## Desinstalación
Si en algún momento deseas desinstalar PostgreSQL 16, usa:

```sh
brew uninstall postgresql@16
```

Si deseas eliminar completamente los datos:

```sh
rm -rf /opt/homebrew/var/postgresql@16
```

## Conclusión
Ahora tienes PostgreSQL 16 instalado y configurado en tu Mac. Puedes utilizar herramientas como `pgAdmin` o conectarte desde cualquier cliente SQL compatible con PostgreSQL.

Para más configuraciones avanzadas, revisa la documentación oficial en [https://www.postgresql.org/docs/16/](https://www.postgresql.org/docs/16/).

