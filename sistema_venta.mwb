use sistema_venta;

create table tipo_usuarios(
id_tipo_usuario INT auto_increment PRIMARY KEY,
nombre_tipo VARCHAR(50) NOT NULL,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

create table usuarios(
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nombre_tipo VARCHAR(100) NOT NULL,
correo VARCHAR(100) UNIQUE,
tipo_usuario_id INT, 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE productos(
id_producto INT auto_increment PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
precio int not null,
stock int not null,
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

CREATE TABLE ventas(
id_venta INT auto_increment PRIMARY KEY,
usuario_id INT,
fecha date,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

CREATE TABLE detalle_ventas(
id_detalle_ventas INT auto_increment PRIMARY KEY,
venta_id INT,
producto_id INT,
cantidad INT,
precio_unitario INT,
updated_at datetime default current_timestamp ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT FALSE);

ALTER TABLE usuarios
ADD CONSTRAINT fk_usuarios_tipo_usuarios
FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id_tipo_usuario);

ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_usuarios
FOREIGN KEY (usuario_id) REFERENCES
usuarios(id_usuario);

ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_ventas_ventas
FOREIGN KEY (venta_id) REFERENCES
ventas(id_venta);

ALTER TABLE detalle_ventas
ADD CONSTRAINT fk_detalle_ventas_productos
FOREIGN KEY (producto_id) REFERENCES
productos(id_producto);

