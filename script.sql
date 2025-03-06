INSERT INTO tipo_usuario (idtipo_usuario, nombre_tipo_usuario, descripcion_tipo_usuario, created) VALUES
('Paciente', 'Usuario que recibe atención médica', NOW()),
('Médico', 'Profesional de la salud', NOW()),
('Administrador', 'Gestor de la clínica', NOW()),
('Recepcionista', 'Encargado de la atención al cliente', NOW()),
('Enfermero', 'Asistente en procedimientos médicos', NOW());

INSERT INTO usuarios (nombre_usuario, contraseña, email, created, tipo_usuario_idtipo_usuario, pacientes_idpaciente) VALUES
('juanp', '123456', 'juan.perez@mail.com', NOW(), 1, 1),
('mariag', 'abcdef', 'maria.gonzalez@mail.com', NOW(), 1, 2),
('carlosr', 'qwerty', 'carlos.ramirez@mail.com', NOW(), 1, 3),
('anal', 'zxcvbn', 'ana.lopez@mail.com', NOW(), 1, 4),
('pedrom', 'password', 'pedro.martinez@mail.com', NOW(), 1, 5);
