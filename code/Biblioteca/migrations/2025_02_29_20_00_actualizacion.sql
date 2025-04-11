-- 1. Agregar una nueva columna telefono a la tabla estudiantes
ALTER TABLE estudiantes ADD COLUMN telefono VARCHAR(20);

-- 2. Modificar la columna cantidad_disponible en libros para que no permita valores negativos
ALTER TABLE libros ALTER COLUMN cantidad_disponible SET DEFAULT 0;
ALTER TABLE libros ADD CONSTRAINT cantidad_disponible_no_negativa CHECK (cantidad_disponible >= 0);

-- 3. Crear una nueva tabla autores
CREATE TABLE autores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    nacionalidad VARCHAR(50)
);

-- 4. Crear una nueva tabla categorias
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50)
);

-- 5. Modificar la tabla libros para referenciar autores y categorias
ALTER TABLE libros DROP COLUMN autor;
ALTER TABLE libros ADD COLUMN autor_id INT REFERENCES autores(id) ON DELETE CASCADE;
ALTER TABLE libros ADD COLUMN categoria_id INT REFERENCES categorias(id) ON DELETE CASCADE;
