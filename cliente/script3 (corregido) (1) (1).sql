USE cliente_db;
DELIMITER //

-- =====================================
-- TABLA: tipo_dispositivos
-- =====================================
CREATE PROCEDURE sp_insertar_tipo_dispositivo(
  IN p_nombre_tipo VARCHAR(100),
  IN p_descripcion TEXT
)
BEGIN
  INSERT INTO tipo_dispositivos(nombre_tipo, descripcion)
  VALUES (p_nombre_tipo, p_descripcion);
END //

CREATE PROCEDURE sp_borrar_tipo_dispositivo(IN p_id INT)
BEGIN
  UPDATE tipo_dispositivos SET deleted = 1 WHERE idtipo_dispositivo = p_id;
END //

CREATE PROCEDURE sp_listar_tipos_dispositivos()
BEGIN
  SELECT * FROM tipo_dispositivos WHERE deleted = 0 ORDER BY idtipo_dispositivo;
END //

CREATE PROCEDURE sp_listar_todo_tipos_dispositivos()
BEGIN
  SELECT * FROM tipo_dispositivos ORDER BY idtipo_dispositivo;
END //

-- =====================================
-- TABLA: dispositivos
-- =====================================
CREATE PROCEDURE sp_insertar_dispositivo(
  IN p_nombre_dispositivo VARCHAR(100),
  IN p_estado_dispositivo VARCHAR(50),
  IN p_tipo_dispositivo INT,
  IN p_sala INT
)
BEGIN
  INSERT INTO dispositivos(nombre_dispositivo, estado_dispositivo, tipo_dispositivos_idtipo_dispositivo, salas_idsalas)
  VALUES (p_nombre_dispositivo, p_estado_dispositivo, p_tipo_dispositivo, p_sala);
END //

CREATE PROCEDURE sp_borrar_dispositivo(IN p_id INT)
BEGIN
  UPDATE dispositivos SET deleted = 1 WHERE iddispositivo = p_id;
END //

CREATE PROCEDURE sp_listar_dispositivos()
BEGIN
  SELECT * FROM dispositivos WHERE deleted = 0 ORDER BY iddispositivo;
END //

CREATE PROCEDURE sp_listar_todo_dispositivos()
BEGIN
  SELECT * FROM dispositivos ORDER BY iddispositivo;
END //

-- =====================================
-- TABLA: usuarios
-- =====================================
CREATE PROCEDURE sp_insertar_usuario(
  IN p_nombre_usuario VARCHAR(100),
  IN p_contraseña VARCHAR(255),
  IN p_correo VARCHAR(250),
  IN p_rol VARCHAR(50),
  IN p_persona_id INT,
  IN p_sala_id INT
)
BEGIN
  INSERT INTO usuarios(nombre_usuario, contraseña, correo, rol, personas_id_persona, salas_idsalas)
  VALUES (p_nombre_usuario, p_contraseña, p_correo, p_rol, p_persona_id, p_sala_id);
END //

CREATE PROCEDURE sp_borrar_usuario(IN p_id INT)
BEGIN
  UPDATE usuarios SET deleted = 1 WHERE id_usuario = p_id;
END //

CREATE PROCEDURE sp_listar_usuarios()
BEGIN
  SELECT * FROM usuarios WHERE deleted = 0 ORDER BY id_usuario;
END //

CREATE PROCEDURE sp_listar_todo_usuarios()
BEGIN
  SELECT * FROM usuarios ORDER BY id_usuario;
END //

-- =====================================
-- TABLA: solicitudes
-- =====================================
CREATE PROCEDURE sp_insertar_solicitud(
  IN p_titulo VARCHAR(100),
  IN p_descripcion TEXT,
  IN p_fecha_solicitud DATE,
  IN p_estado_id INT,
  IN p_usuario_id INT
)
BEGIN
  INSERT INTO solicitudes(titulo, descripcion, fecha_solicitud, estados_solicitud_id, usuarios_id_usuario)
  VALUES (p_titulo, p_descripcion, p_fecha_solicitud, p_estado_id, p_usuario_id);
END //

CREATE PROCEDURE sp_borrar_solicitud(IN p_id INT)
BEGIN
  UPDATE solicitudes SET deleted = 1 WHERE id_solicitud = p_id;
END //

CREATE PROCEDURE sp_listar_solicitudes()
BEGIN
  SELECT * FROM solicitudes WHERE deleted = 0 ORDER BY id_solicitud;
END //

CREATE PROCEDURE sp_listar_todo_solicitudes()
BEGIN
  SELECT * FROM solicitudes ORDER BY id_solicitud;
END //

-- =====================================
-- TABLA: cargos
-- =====================================
CREATE PROCEDURE sp_listar_cargos()
BEGIN
    SELECT * FROM cargos WHERE deleted = 0 ORDER BY idcargo;
END //

-- =====================================
-- TABLA: tipo_usuarios
-- =====================================
CREATE PROCEDURE sp_insertar_tipo_usuario(
  IN p_nombre_tipo VARCHAR(50),
  IN p_descripcion_tipo TEXT
)
BEGIN
  INSERT INTO tipo_usuarios(nombre_tipo, descripcion_tipo)
  VALUES (p_nombre_tipo, p_descripcion_tipo);
END //

CREATE PROCEDURE sp_borrar_tipo_usuario(IN p_id INT)
BEGIN
  UPDATE tipo_usuarios SET deleted = 1 WHERE idtipo_usuario = p_id;
END //

CREATE PROCEDURE sp_listar_tipo_usuarios()
BEGIN
  SELECT * FROM tipo_usuarios WHERE deleted = 0 ORDER BY idtipo_usuario;
END //

CREATE PROCEDURE sp_listar_todo_tipo_usuarios()
BEGIN
  SELECT * FROM tipo_usuarios ORDER BY idtipo_usuario;
END //

-- =====================================
-- TABLA: estado_mantenimientos
-- =====================================
CREATE PROCEDURE sp_insertar_estado_mantenimiento(
  IN p_nombre_estado VARCHAR(50),
  IN p_descripcion TEXT
)
BEGIN
  INSERT INTO estado_mantenimientos(nombre_estado, descripcion)
  VALUES (p_nombre_estado, p_descripcion);
END //

CREATE PROCEDURE sp_borrar_estado_mantenimiento(IN p_id INT)
BEGIN
  UPDATE estado_mantenimientos SET deleted = 1 WHERE idestado_mantenimiento = p_id;
END //

CREATE PROCEDURE sp_listar_estado_mantenimientos()
BEGIN
  SELECT * FROM estado_mantenimientos WHERE deleted = 0 ORDER BY idestado_mantenimiento;
END //

CREATE PROCEDURE sp_listar_todo_estado_mantenimientos()
BEGIN
  SELECT * FROM estado_mantenimientos ORDER BY idestado_mantenimiento;
END //

-- =====================================
-- TABLA: mantenimientos
-- =====================================
CREATE PROCEDURE sp_insertar_mantenimiento(
  IN p_fecha DATE,
  IN p_observaciones VARCHAR(255),
  IN p_encargado_usuario INT,
  IN p_estado_mantenimiento INT,
  IN p_dispositivo INT
)
BEGIN
  INSERT INTO mantenimientos(fecha, observaciones, encargado_usuario_id, estado_mantenimientos_id, dispositivos_iddispositivo)
  VALUES (p_fecha, p_observaciones, p_encargado_usuario, p_estado_mantenimiento, p_dispositivo);
END //

CREATE PROCEDURE sp_borrar_mantenimiento(IN p_id INT)
BEGIN
  UPDATE mantenimientos SET deleted = 1 WHERE idmantenimiento = p_id;
END //

CREATE PROCEDURE sp_listar_mantenimientos()
BEGIN
  SELECT * FROM mantenimientos WHERE deleted = 0 ORDER BY idmantenimiento;
END //

CREATE PROCEDURE sp_listar_todo_mantenimientos()
BEGIN
  SELECT * FROM mantenimientos ORDER BY idmantenimiento;
END //

DELIMITER ;
-- =====================================
-- TIPOS DE DISPOSITIVOS
-- =====================================
CALL sp_insertar_tipo_dispositivo('Impresora 3D', 'Dispositivo para impresión FDM y modelado rápido');
CALL sp_insertar_tipo_dispositivo('Impresora de resina', 'Impresora SLA para piezas detalladas');
CALL sp_insertar_tipo_dispositivo('Cortadora láser', 'Equipo de corte y grabado de materiales');
CALL sp_insertar_tipo_dispositivo('Computadora', 'Equipo de trabajo para diseño y control de impresión');

-- =====================================
-- DISPOSITIVOS
-- =====================================
CALL sp_insertar_dispositivo('Creality Ender 3', 'Operativo', 1, 1);
CALL sp_insertar_dispositivo('Elegoo Mars 4', 'En revisión', 2, 2);
CALL sp_insertar_dispositivo('Glowforge Pro', 'Operativo', 3, 3);
CALL sp_insertar_dispositivo('HP Z4 Workstation', 'Operativo', 4, 4);

-- =====================================
-- PERSONAS
-- =====================================
INSERT ignore personas(nombres, apellidos, rut, telefono, direccion, correo)
VALUES
('Sofía', 'Méndez Luna', '10123456-7', '912345678', 'Calle Falsa 123', 'sofia.mendez@example.com'),
('Carlos', 'Rivera Soto', '10987654-3', '912345679', 'Avenida Siempre Viva 742', 'carlos.rivera@example.com'),
('Elena', 'Vargas Castro', '20112233-1', '912345680', 'Calle Nueva 45', 'elena.vargas@example.com'),
('Javier', 'Pérez Gómez', '10778899-5', '912345681', 'Camino Real 88', 'javier.perez@example.com'),
('Laura', 'Díaz Silva', '30445566-8', '912345682', 'Pasaje Los Pinos 9', 'laura.diaz@example.com');




-- =====================================
-- USUARIOS
-- =====================================
CALL sp_insertar_usuario('mrojas', 'docente456', 'mrojas@uni.cl', 'Cliente', 2, NULL);
CALL sp_insertar_usuario('alopez', 'mantenimiento789', 'alopez@uni.cl', 'Técnico', 3, NULL);
CALL sp_insertar_usuario('pmendez', 'laser2024', 'pmendez@uni.cl', 'Cliente', 4, NULL);
CALL sp_insertar_usuario('lpinto', 'cad999', 'lpinto@uni.cl', 'Cliente', 5, NULL);

-- =====================================
-- ESTADOS DE SOLICITUD
-- =====================================
INSERT INTO estados_solicitud(nombre_estado, descripcion) VALUES
('Pendiente', 'A la espera de revisión'),
('En curso', 'Solicitud en proceso'),
('Resuelta', 'Solicitud completada');

-- =====================================
-- SOLICITUDES
-- =====================================
CALL sp_insertar_solicitud('Mantenimiento Impresora', 'Revisión de Creality Ender 3 por atasco de filamento', '2025-10-10', 1, 2);
CALL sp_insertar_solicitud('Actualización Software', 'Actualizar controladores de la HP Z4 Workstation', '2025-10-11', 2, 3);
CALL sp_insertar_solicitud('Chequeo General', 'Revisión de todos los dispositivos de Sala B', '2025-10-12', 2, 1);
CALL sp_insertar_solicitud('Revisión Laboratorio', 'Chequeo de sensores y cámaras de la Glowforge Pro', '2025-10-13', 3, 4);

-- =====================================
-- TIPOS DE USUARIOS
-- =====================================
CALL sp_insertar_tipo_usuario('Administrador', 'Acceso completo al sistema');
CALL sp_insertar_tipo_usuario('Docente', 'Usuario con acceso a recursos y reservas');
CALL sp_insertar_tipo_usuario('Encargado de mantenimiento', 'Gestiona mantenimiento de equipos');
CALL sp_insertar_tipo_usuario('Estudiante', 'Acceso restringido y supervisado');

-- =====================================
-- ESTADOS DE MANTENIMIENTOS
-- =====================================
CALL sp_insertar_estado_mantenimiento('Programado', 'Mantenimiento agendado');
CALL sp_insertar_estado_mantenimiento('En progreso', 'Mantenimiento en curso');
CALL sp_insertar_estado_mantenimiento('Finalizado', 'Mantenimiento completado correctamente');

-- =====================================
-- MANTENIMIENTOS
-- =====================================
CALL sp_insertar_mantenimiento('2025-10-10', 'Limpieza del extrusor y calibración', 3, 3, 1);
CALL sp_insertar_mantenimiento('2025-10-11', 'Cambio de resina y limpieza', 3, 2, 2);
CALL sp_insertar_mantenimiento('2025-10-12', 'Revisión óptica del láser', 4, 3, 3);
CALL sp_insertar_mantenimiento('2025-10-13', 'Actualización de controladores CAD', 2, 1, 4);

