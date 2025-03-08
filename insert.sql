ALTER TABLE tipo_usuario MODIFY COLUMN descripcion_tipo_usuario VARCHAR(100);

INSERT INTO `consulta_medica`.`tipo_usuario` (idtipo_usuario, nombre_tipo_usuario, descripcion_tipo_usuario, created)
VALUES
  (1, 'Administrador', 'Usuario con permisos completos', NOW()),
  (2, 'Médico', 'Usuario encargado de realizar las consultas médicas', NOW()),
  (3, 'Paciente', 'Usuario que recibe atención médica', NOW()),
  (4, 'Recepcionista', 'Usuario encargado de gestionar las citas médicas', NOW()),
  (5, 'Enfermero', 'Usuario que asiste a los médicos en el cuidado de los pacientes', NOW());
  
  INSERT INTO `consulta_medica`.`citas_medicas` (idcita_medica, fecha_hora, motivo_consulta, citas_medicascol, estado, created)
VALUES
  (1, '2025-03-10 09:00:00', 'Consulta general', 'Cita regular', 'Confirmada', NOW()),
  (2, '2025-03-10 10:00:00', 'Chequeo anual', 'Cita de revisión', 'Confirmada', NOW()),
  (3, '2025-03-11 14:30:00', 'Dolor de cabeza crónico', 'Cita urgente', 'Pendiente', NOW()),
  (4, '2025-03-12 08:00:00', 'Revisión post-operatoria', 'Seguimiento', 'Confirmada', NOW()),
  (5, '2025-03-12 15:00:00', 'Problemas respiratorios', 'Cita médica', 'Cancelada', NOW());
  
  INSERT INTO `consulta_medica`.`historial_medico` (idhistorial_medico, fecha_registro, diagnostico, tratamiento, notas_adicionales, created)
VALUES
  (1, '2025-03-10 09:30:00', 'Hipertensión', 'Medicamentos para reducir la presión', 'Requiere revisión semanal', NOW()),
  (2, '2025-03-11 10:00:00', 'Diabetes tipo 2', 'Insulina y dieta controlada', 'Paciente debe seguir plan de ejercicios', NOW()),
  (3, '2025-03-12 08:15:00', 'Resfriado común', 'Antigripales y descanso', 'Controlado en 3 días', NOW()),
  (4, '2025-03-13 14:30:00', 'Asma', 'Inhaladores y medicación diaria', 'Seguimiento mensual', NOW()),
  (5, '2025-03-14 16:00:00', 'Artritis', 'Antiinflamatorios y ejercicios', 'Paciente en tratamiento a largo plazo', NOW());

INSERT INTO `consulta_medica`.`pacientes` (idpaciente, nombre, apellido, fecha_nacimiento, direccion, telefono, created, citas_medicas_idcita_medica, historial_medico_idhistorial_medico)
VALUES
  (1, 'Juan', 'Pérez', '1990-05-12', 'Calle Falsa 123', '555123456', NOW(), 1, 1),
  (2, 'María', 'López', '1985-09-20', 'Avenida Libertad 456', '555654321', NOW(), 2, 2),
  (3, 'Carlos', 'Gómez', '1992-11-25', 'Calle 2 #789', '555987654', NOW(), 3, 3),
  (4, 'Ana', 'Ramírez', '1980-02-14', 'Calle 3 #101', '555321987', NOW(), 4, 4),
  (5, 'Luis', 'Fernández', '1995-07-30', 'Calle 4 #202', '555741258', NOW(), 5, 5);
  
  INSERT INTO `consulta_medica`.`medico` (idmedico, nombre, apellido, especialidad, telefono, created, citas_medicas_idcita_medica)
VALUES
  (1, 'Dr. Juan', 'Méndez', 'Cardiólogo', '555111223', NOW(), 1),
  (2, 'Dr. Pedro', 'González', 'Dermatólogo', '555222334', NOW(), 2),
  (3, 'Dr. Carla', 'Martínez', 'Pediatra', '555333445', NOW(), 3),
  (4, 'Dr. Roberto', 'López', 'Ginecólogo', '555444556', NOW(), 4),
  (5, 'Dr. Raúl', 'Rodríguez', 'Neurólogo', '555555667', NOW(), 5);
  
  INSERT INTO `consulta_medica`.`administrativos` (idadministrativo, nombre, apellido, telefono, created)
VALUES
  (1, 'José', 'Pérez', '555666777', NOW()),
  (2, 'Luis', 'Gómez', '555777888', NOW()),
  (3, 'Carla', 'López', '555888999', NOW()),
  (4, 'María', 'Rodríguez', '555999000', NOW()),
  (5, 'Juan', 'Fernández', '555000111', NOW());
  
  INSERT INTO `consulta_medica`.`usuarios` (idusuarios, nombre_usuario, contraseña, email, created, tipo_usuario_idtipo_usuario, pacientes_idpaciente, medico_idmedico, administrativos_idadministrativo)
VALUES
  (1, 'jperez85', 'clave123', 'juan.perez@mail.com', NOW(), 3, 1, 1, 1),
  (2, 'mlopez90', 'pass456', 'maria.lopez@mail.com', NOW(), 2, 2, 2, 2),
  (3, 'cgomez78', 'clave789', 'carlos.gomez@mail.com', NOW(), 3, 3, 3, 3),
  (4, 'aramirez00', 'abc123', 'ana.ramirez@mail.com', NOW(), 1, 4, 4, 4),
  (5, 'lfernandez65', 'pass852', 'luis.fernandez@mail.com', NOW(), 4, 5, 5, 5);
  
  ALTER TABLE `consulta_medica`.`usuarios`
  DROP FOREIGN KEY `fk_usuarios_tipo_usuario`,
  DROP FOREIGN KEY `fk_usuarios_pacientes1`,
  DROP FOREIGN KEY `fk_usuarios_medico1`,
  DROP FOREIGN KEY `fk_usuarios_administrativos1`;
  
  ALTER TABLE `consulta_medica`.`usuarios`
  ADD CONSTRAINT `fk_usuarios_tipo_usuario`
    FOREIGN KEY (`tipo_usuario_idtipo_usuario`)
    REFERENCES `consulta_medica`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuarios_pacientes1`
    FOREIGN KEY (`pacientes_idpaciente`)
    REFERENCES `consulta_medica`.`pacientes` (`idpaciente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuarios_medico1`
    FOREIGN KEY (`medico_idmedico`)
    REFERENCES `consulta_medica`.`medico` (`idmedico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuarios_administrativos1`
    FOREIGN KEY (`administrativos_idadministrativo`)
    REFERENCES `consulta_medica`.`administrativos` (`idadministrativo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;