
DROP DATABASE IF EXISTS cliente_db;
CREATE DATABASE cliente_db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE cliente_db;

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- TABLA: personas
-- ============================================================
CREATE TABLE personas (
  id_persona INT AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  rut VARCHAR(12) UNIQUE NOT NULL,
  telefono VARCHAR(20),
  direccion VARCHAR(255),
  correo VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT(1) DEFAULT 0
);

-- ============================================================
-- TABLA: cargos
-- ============================================================
CREATE TABLE cargos (
  idcargo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_cargo VARCHAR(100) NOT NULL,
  descripcion TEXT,
  deleted TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLA: salas
-- ============================================================
CREATE TABLE salas (
  idsalas INT AUTO_INCREMENT PRIMARY KEY,
  nombre_sala VARCHAR(100) NOT NULL,
  ubicacion VARCHAR(100),
  cantidad_dispositivos INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT(1) DEFAULT 0
);

-- tipo_usuarios
CREATE TABLE tipo_usuarios (
    idtipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion_tipo TEXT,
    deleted TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ============================================================
-- TABLA: usuarios
-- ============================================================
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
  contraseña VARCHAR(255) NOT NULL,
  correo VARCHAR(250) NOT NULL,
  rol ENUM('Administrador', 'Técnico', 'Cliente') DEFAULT 'Cliente',
  estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
  personas_id_persona INT,
  salas_idsalas INT,
  deleted TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (personas_id_persona) REFERENCES personas(id_persona)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (salas_idsalas) REFERENCES salas(idsalas)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
 
-- ============================================================
-- TABLA: tipo_dispositivos
-- ============================================================
CREATE TABLE tipo_dispositivos (
  idtipo_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_tipo VARCHAR(100) NOT NULL,
  descripcion TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted TINYINT(1) DEFAULT 0
);

-- ============================================================
-- TABLA: dispositivos
-- ============================================================
CREATE TABLE dispositivos (
  iddispositivo INT AUTO_INCREMENT PRIMARY KEY,
  nombre_dispositivo VARCHAR(100) NOT NULL,
  estado_dispositivo ENUM('Operativo', 'En revisión', 'Fuera de servicio') DEFAULT 'Operativo',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted TINYINT(1) DEFAULT 0,
  tipo_dispositivos_idtipo_dispositivo INT,
  salas_idsalas INT,
  FOREIGN KEY (tipo_dispositivos_idtipo_dispositivo) REFERENCES tipo_dispositivos(idtipo_dispositivo)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  FOREIGN KEY (salas_idsalas) REFERENCES salas(idsalas)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- ============================================================
-- TABLA: estados_solicitud
-- ============================================================
CREATE TABLE estados_solicitud (
  id_estado INT AUTO_INCREMENT PRIMARY KEY,
  nombre_estado VARCHAR(50) NOT NULL,
  descripcion TEXT,
  deleted TINYINT(1) DEFAULT 0
);

-- Insert inicial para evitar error en solicitudes con DEFAULT 1
INSERT INTO estados_solicitud (nombre_estado, descripcion)
VALUES ('Pendiente', 'Solicitud creada en espera de revisión');

-- ============================================================
-- TABLA: solicitudes
-- ============================================================
CREATE TABLE solicitudes (
  id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  descripcion TEXT,
  fecha_solicitud DATE NOT NULL,
  estados_solicitud_id INT NOT NULL DEFAULT 1,
  usuarios_id_usuario INT NOT NULL,
  deleted TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (estados_solicitud_id) REFERENCES estados_solicitud(id_estado)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (usuarios_id_usuario) REFERENCES usuarios(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

SET FOREIGN_KEY_CHECKS = 1;

-- estado_dispositivos
CREATE TABLE estado_dispositivos (
    idestado_dispositivo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL,
    descripcion TEXT,
    deleted TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- estado_mantenimientos
CREATE TABLE estado_mantenimientos (
    idestado_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL,
    descripcion TEXT,
    deleted TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT NOW()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- mantenimientos
CREATE TABLE mantenimientos (
  idmantenimiento INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATE NOT NULL,
  observaciones VARCHAR(255),
  encargado_usuario_id INT NOT NULL,
  estado_mantenimientos_id INT NULL,
  dispositivos_iddispositivo INT NOT NULL,
  deleted TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (encargado_usuario_id) REFERENCES usuarios(id_usuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (estado_mantenimientos_id) REFERENCES estado_mantenimientos(idestado_mantenimiento)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  FOREIGN KEY (dispositivos_iddispositivo) REFERENCES dispositivos(iddispositivo)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- ============================================================
-- RELACIÓN FINAL: encargado de sala (fuera del ciclo)
-- ============================================================
ALTER TABLE salas 
  ADD COLUMN encargado_usuario_id INT NULL AFTER cantidad_dispositivos,
  ADD INDEX fk_sala_encargado_idx (encargado_usuario_id ASC),
  ADD CONSTRAINT fk_sala_encargado
    FOREIGN KEY (encargado_usuario_id)
    REFERENCES usuarios (id_usuario)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE personas
ADD COLUMN cargos_idcargo INT,
ADD CONSTRAINT fk_persona_cargo
  FOREIGN KEY (cargos_idcargo)
  REFERENCES cargos(idcargo)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

