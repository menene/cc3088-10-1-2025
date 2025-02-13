# Guía de Instalación y Configuración de PostgreSQL 16 en Linux (Ubuntu y Arch Linux)

## Instalación en Ubuntu
### Prerrequisitos
Antes de comenzar, asegúrate de actualizar los paquetes del sistema:

```sh
sudo apt update && sudo apt upgrade -y
```

### Instalación de PostgreSQL 16
Ejecuta los siguientes comandos para agregar el repositorio oficial y proceder con la instalación:

```sh
sudo apt install -y wget gnupg
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/postgresql.asc
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

sudo apt update
sudo apt install -y postgresql-16
```

### Iniciar el Servicio
Para asegurarte de que PostgreSQL se ejecuta correctamente:

```sh
sudo systemctl enable --now postgresql
```

Para verificar el estado del servicio:

```sh
sudo systemctl status postgresql
```

### Configuración Inicial
Para acceder a la consola de PostgreSQL, ejecuta:

```sh
sudo -u postgres psql
```

Para cambiar la contraseña del usuario `postgres`:

```sql
ALTER USER postgres PASSWORD 'tu_contraseña';
```

Salir de `psql` con:

```sql
\q
```

## Instalación en Arch Linux
### Prerrequisitos
Antes de instalar PostgreSQL, actualiza los paquetes del sistema:

```sh
sudo pacman -Syu
```

### Instalación de PostgreSQL 16
Instala PostgreSQL ejecutando:

```sh
sudo pacman -S postgresql
```

### Inicialización y Configuración
Antes de iniciar el servicio, inicializa la base de datos con:

```sh
sudo -u postgres initdb -D /var/lib/postgres/data
```

Inicia y habilita el servicio:

```sh
sudo systemctl enable --now postgresql
```

Para verificar el estado del servicio:

```sh
sudo systemctl status postgresql
```

### Configuración Inicial
Para acceder a la consola de PostgreSQL, ejecuta:

```sh
sudo -u postgres psql
```

Para cambiar la contraseña del usuario `postgres`:

```sql
ALTER USER postgres PASSWORD 'tu_contraseña';
```

Salir de `psql` con:

```sql
\q
```

## Configuración Adicional para Ambas Distribuciones
Si deseas permitir conexiones remotas, edita el archivo `postgresql.conf`:

```sh
sudo nano /etc/postgresql/16/main/postgresql.conf  # Ubuntu
sudo nano /var/lib/postgres/data/postgresql.conf  # Arch Linux
```

Busca la línea:

```
#listen_addresses = 'localhost'
```

y cámbiala a:

```
listen_addresses = '*'
```

Luego, edita el archivo `pg_hba.conf` para permitir autenticación por contraseña:

```sh
sudo nano /etc/postgresql/16/main/pg_hba.conf  # Ubuntu
sudo nano /var/lib/postgres/data/pg_hba.conf  # Arch Linux
```

Modifica la siguiente línea:

```
host    all             all             0.0.0.0/0               md5
```

Guarda los cambios y reinicia PostgreSQL:

```sh
sudo systemctl restart postgresql
```

## Verificar la Instalación
Para asegurarte de que PostgreSQL está funcionando correctamente, ejecuta:

```sh
pg_isready
```

Si ves una salida como `postgresql:5432 - accepting connections`, significa que PostgreSQL está funcionando correctamente.

Para listar las bases de datos disponibles:

```sh
sudo -u postgres psql -c "\l"
```

## Desinstalación
Si deseas desinstalar PostgreSQL:

### En Ubuntu
```sh
sudo apt remove --purge -y postgresql-16
sudo rm -rf /var/lib/postgresql
sudo rm -rf /etc/postgresql
```

### En Arch Linux
```sh
sudo pacman -Rns postgresql
sudo rm -rf /var/lib/postgres
```

## Conclusión
Ahora tienes PostgreSQL 16 instalado y configurado en Ubuntu y Arch Linux. Puedes utilizar herramientas como `pgAdmin` o conectarte desde cualquier cliente SQL compatible con PostgreSQL.

Para más configuraciones avanzadas, revisa la documentación oficial en [https://www.postgresql.org/docs/16/](https://www.postgresql.org/docs/16/).

