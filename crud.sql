UPDATE `consulta_medica`.`tipo_usuario` 
SET descripcion_tipo_usuario = 'Usuario con acceso limitado'
WHERE idtipo_usuario = 1;

UPDATE `consulta_medica`.`citas_medicas` 
SET estado = 'Cancelada'
WHERE idcita_medica = 2;

UPDATE `consulta_medica`.`historial_medico` 
SET tratamiento = 'Nuevas dosis de medicamento', notas_adicionales = 'Revisión urgente'
WHERE idhistorial_medico = 3;

UPDATE `consulta_medica`.`pacientes` 
SET telefono = '3201234567'
WHERE idpaciente = 1;

UPDATE `consulta_medica`.`medico` 
SET especialidad = 'Cardiología'
WHERE idmedico = 2;

UPDATE `consulta_medica`.`administrativos` 
SET nombre = 'Roberto'
WHERE idadministrativo = 1;

UPDATE `consulta_medica`.`usuarios` 
SET contraseña = 'nuevaClave123'
WHERE idusuarios = 3;

DELETE FROM `consulta_medica`.`tipo_usuario` 
WHERE idtipo_usuario = 5;

DELETE FROM `consulta_medica`.`citas_medicas` 
WHERE idcita_medica = 4;

DELETE FROM `consulta_medica`.`historial_medico` 
WHERE idhistorial_medico = 3;

DELETE FROM `consulta_medica`.`pacientes` 
WHERE idpaciente = 2;

DELETE FROM `consulta_medica`.`medico` 
WHERE idmedico = 1;

DELETE FROM `consulta_medica`.`usuarios` 
WHERE idusuarios = 4;

DELETE FROM `consulta_medica`.`administrativos` 
WHERE idadministrativo = 3;






