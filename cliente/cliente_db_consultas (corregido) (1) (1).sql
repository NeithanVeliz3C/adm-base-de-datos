use cliente_db;

-- 🔹 Tabla: cargos
INSERT INTO cargos (nombre_cargo, descripcion, deleted, created_at)
VALUES
('Técnico de laboratorio', 'Encargado de revisiones técnicas de equipos', 0, NOW()),
('Administrador de sistemas', 'Gestiona usuarios y configuraciones', 0, NOW()),
('Docente', 'Profesor encargado de proyectos 3D', 0, NOW()),
('Asistente de mantenimiento', 'Ayuda en tareas de revisión y mantenimiento', 0, NOW());

-- 🔹 Tabla: personas
INSERT INTO personas (nombres, apellidos, rut, telefono, direccion, correo, deleted, created_at) VALUES
('Sofía', 'Méndez Luna', '10123456-7', '912345678', 'Calle Falsa 123', 'sofia.mendez@example.com', 0, NOW()),
('Carlos', 'Rivera Soto', '10987654-3', '912345679', 'Avenida Siempre Viva 742', 'carlos.rivera@example.com', 0, NOW()),
('Elena', 'Vargas Castro', '20112233-1', '912345680', 'Calle Nueva 45', 'elena.vargas@example.com', 0, NOW()),
('Javier', 'Pérez Gómez', '10778899-5', '912345681', 'Camino Real 88', 'javier.perez@example.com', 0, NOW()),
('Laura', 'Díaz Silva', '30445566-8', '912345682', 'Pasaje Los Pinos 9', 'laura.diaz@example.com', 0, NOW());

-- 🔹 Tabla: usuarios
INSERT INTO usuarios (nombre_usuario, contraseña, correo, rol, personas_id_persona, salas_idsalas, deleted, created_at) VALUES
('admin3d', 'admin123', 'admin@sala3d.cl', 'Administrador', 1, NULL, 0, NOW()),
('mrojas', 'docente456', 'mrojas@uni.cl', 'Cliente', 2, NULL, 0, NOW()),
('alopez', 'mantenimiento789', 'alopez@uni.cl', 'Técnico', 3, NULL, 0, NOW()),
('pmendez', 'laser2024', 'pmendez@uni.cl', 'Cliente', 4, NULL, 0, NOW()),
('lpinto', 'cad999', 'lpinto@uni.cl', 'Cliente', 5, NULL, 0, NOW());

-- 🔹 Tabla: tipo_dispositivo
INSERT INTO tipo_dispositivos (nombre_tipo, descripcion, deleted)
VALUES
('Impresora 3D', 'Dispositivo para impresión FDM y modelado rápido', 0),
('Impresora de resina', 'Impresora SLA para piezas detalladas', 0),
('Cortadora láser', 'Equipo de corte y grabado de materiales', 0),
('Computadora', 'Equipo de trabajo para diseño y control de impresión', 0);

-- 🔹 Tabla: estado_dispositivos
INSERT INTO estado_dispositivos (nombre_estado, descripcion, deleted, created_at)
VALUES
('Operativo', 'El dispositivo está en uso normal', 0, NOW()),
('En mantenimiento', 'Actualmente en reparación o revisión', 0, NOW()),
('Inactivo', 'Fuera de servicio temporalmente', 0, NOW());

-- 🔹 Tabla: salas
INSERT INTO salas (nombre_sala, ubicacion, cantidad_dispositivos) VALUES
('Sala A - Prototipado', 'Edificio Principal, Piso 1', 5),
('Sala B - Impresión de Resina', 'Edificio Principal, Piso 1', 3),
('Sala C - Corte Láser', 'Edificio Principal, Piso 2', 2),
('Sala D - Diseño CAD', 'Edificio Anexo, Piso 1', 6),
('Sala E - Experimentación', 'Edificio Anexo, Piso 2', 4);

-- 🔹 Tabla: dispositivos
INSERT INTO dispositivos (nombre_dispositivo, estado_dispositivo, tipo_dispositivos_idtipo_dispositivo, salas_idsalas, deleted, created_at) VALUES
('Creality Ender 3', 'Operativo', 1, 1, 0, NOW()),
('Elegoo Mars 4', 'En revisión', 2, 2, 0, NOW()),
('Glowforge Pro', 'Operativo', 3, 3, 0, NOW()),
('HP Z4 Workstation', 'Operativo', 4, 4, 0, NOW());

-- 🔹 Tabla: estado_mantenimientos
INSERT INTO estado_mantenimientos (nombre_estado, descripcion, deleted, created_at)
VALUES
('Programado', 'Mantenimiento agendado', 0, NOW()),
('En progreso', 'Mantenimiento en curso', 0, NOW()),
('Finalizado', 'Mantenimiento completado correctamente', 0, NOW());

-- 🔹 Tabla: mantenimientos
INSERT INTO mantenimientos (fecha, observaciones, encargado_usuario_id, estado_mantenimientos_id, dispositivos_iddispositivo, deleted, created_at)
VALUES
('2025-10-10', 'Limpieza del extrusor y calibración', 1, 3, 1, 0, NOW()),
('2025-10-11', 'Cambio de resina y limpieza', 2, 2, 2, 0, NOW()),
('2025-10-12', 'Revisión óptica del láser', 3, 3, 3, 0, NOW()),
('2025-10-13', 'Actualización de controladores CAD', 4, 1, 4, 0, NOW());

select * from estado_mantenimientos;
SELECT id_usuario, nombre_usuario FROM usuarios;

-- 🔹 Tabla: estados_solicitud
INSERT INTO estados_solicitud (nombre_estado, descripcion, deleted)
VALUES
('Pendiente', 'A la espera de revisión', 0),
('En curso', 'Solicitud en proceso', 0),
('Resuelta', 'Solicitud completada', 0);

-- 🔹 Tabla: solicitudes
INSERT INTO solicitudes (titulo, descripcion, fecha_solicitud, estados_solicitud_id, usuarios_id_usuario, deleted, created_at)
VALUES
('Mantenimiento Impresora', 'Revisión de Creality Ender 3 por atasco de filamento', '2025-10-10', 1, 1, 0, NOW()),
('Actualización Software', 'Actualizar controladores de la HP Z4 Workstation', '2025-10-11', 2, 2, 0, NOW()),
('Chequeo General', 'Revisión de todos los dispositivos de Sala B', '2025-10-12', 2, 3, 0, NOW()),
('Revisión Laboratorio', 'Chequeo de sensores y cámaras de la Glowforge Pro', '2025-10-13', 3, 4, 0, NOW());

-- 🔹 Tabla: tipo_usuarios
INSERT INTO tipo_usuarios (nombre_tipo, descripcion_tipo, deleted, created_at)
VALUES
('Administrador', 'Acceso completo al sistema', 0, NOW()),
('Docente', 'Usuario con acceso a recursos y reservas', 0, NOW()),
('Encargado de mantenimiento', 'Gestiona mantenimiento de equipos', 0, NOW()),
('Estudiante', 'Acceso restringido y supervisado', 0, NOW());


-- ----------------------------
-- Consultas generales
-- ----------------------------
SELECT * FROM tipo_dispositivos;
SELECT * FROM salas;
SELECT * FROM dispositivos;
SELECT * FROM mantenimientos;
SELECT * FROM tipo_usuarios;
SELECT * FROM usuarios;
SELECT * FROM solicitudes;
SELECT * FROM cargos;
SELECT * FROM estados_solicitud;
SELECT * FROM estado_mantenimientos;
SELECT * FROM estado_dispositivos;

-- ----------------------------
-- Consultas con filtro de eliminados
-- ----------------------------
SELECT * FROM dispositivos WHERE deleted = 0 OR deleted IS NULL;
SELECT * FROM usuarios WHERE deleted = 0 OR deleted IS NULL;

-- ----------------------------
-- Verificar qué dispositivos pertenecen a cada sala y su estado actual
-- ----------------------------
SELECT 
    s.nombre_sala, 
    d.nombre_dispositivo, 
    ed.nombre_estado AS estado_actual
FROM dispositivos d
JOIN salas s ON d.salas_idsalas = s.idsalas
JOIN estado_dispositivos ed ON d.tipo_dispositivos_idtipo_dispositivo = ed.idestado_dispositivo
LIMIT 0, 1000;

-- ----------------------------
-- Verificar los mantenimientos realizados por dispositivo y su estado
-- ----------------------------
SELECT 
    d.nombre_dispositivo, 
    m.fecha, 
    u.nombre_usuario AS encargado_usuario,
    em.nombre_estado AS estado_mantenimiento,
    m.observaciones
FROM mantenimientos m
JOIN dispositivos d ON m.dispositivos_iddispositivo = d.iddispositivo
JOIN estado_mantenimientos em ON m.estado_mantenimientos_id = em.idestado_mantenimiento
JOIN usuarios u ON m.encargado_usuario_id = u.id_usuario
LIMIT 0, 1000;

-- ----------------------------
-- Verificar qué usuarios son encargados de cada sala
-- ----------------------------
SELECT 
    s.nombre_sala, 
    u.nombre_usuario AS encargado
FROM salas s
LEFT JOIN usuarios u ON u.salas_idsalas = s.idsalas
LIMIT 0, 1000;

-- ----------------------------
-- Verificar qué persona corresponde a cada usuario
-- ----------------------------
SELECT 
    u.nombre_usuario,
    p.nombres,
    p.apellidos,
    c.nombre_cargo
FROM usuarios u
JOIN personas p ON u.personas_id_persona = p.id_persona
LEFT JOIN cargos c ON p.cargos_idcargo = c.idcargo;


