USE ejemploSelect;

-- Tabla: tipo_usuarios
CREATE TABLE tipo_usuarios (
    id_tipo INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion_tipo VARCHAR(200) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)) -- Validación lógica de booleano
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE CHECK (LENGTH(username) >= 5), -- Nombre de usuario mínimo 5 caracteres
    password VARCHAR(200) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_tipo_usuario INT,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)), -- Se añade check para mantener consistencia
    CONSTRAINT fk_usuarios_tipo_usuarios FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuarios(id_tipo)
);

-- Tabla: ciudad
CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(100) NOT NULL CHECK (LENGTH(nombre_ciudad) >= 3), -- El nombre de la ciudad debe tener al menos 3 letras
    region VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)) -- Validación lógica de booleano
);

-- Tabla: personas
CREATE TABLE personas (
    rut VARCHAR(13) NOT NULL UNIQUE, 
    nombre_completo VARCHAR(100) NOT NULL CHECK (LENGTH(nombre_completo) >= 5), -- Nombre completo mínimo 5 letras
    estado_persona VARCHAR(20) CHECK (estado_persona IN ('activo', 'inactivo', 'pendiente')), -- Check útil en nuevo campo
    fecha_nac DATE CHECK (fecha_nac <= CURRENT_DATE), -- Fecha de nacimiento no puede estar en el futuro
    id_usuario INT,
    id_ciudad INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    deleted BOOLEAN DEFAULT FALSE CHECK (deleted IN (0, 1)), -- Validación lógica de booleano
    CONSTRAINT fk_personas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_personas_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);
