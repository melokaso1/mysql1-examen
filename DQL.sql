-- consulta 1
SELECT 
    prof.id AS id_profesional,
    prof.nombre_profesional AS medico,
    ac.nombre_area AS especialidad,
    COUNT(DISTINCT t.id_persona) AS total_pacientes
FROM profesionales prof
INNER JOIN areas_clinicas ac ON prof.id_area = ac.id
INNER JOIN turnos t ON prof.id = t.id_profesional
GROUP BY prof.id, prof.nombre_profesional, ac.nombre_area
ORDER BY total_pacientes DESC;

-- consulta 2
SELECT 
    COUNT(*) AS total,
    s.nombre_sede AS tipo_sede
FROM turnos t
INNER JOIN sedes_atencion s ON t.id_sede = s.id
WHERE s.nombre_sede = 'Centro Médico'

UNION

SELECT 
    COUNT(*) AS total,
    s.nombre_sede AS tipo_sede
FROM turnos t
INNER JOIN sedes_atencion s ON t.id_sede = s.id
WHERE s.nombre_sede = 'Clínica Norte';

-- consulta 3
SELECT 
    prof.id AS id_profesional,
    prof.nombre_profesional AS medico,
    ac.nombre_area AS especialidad,
    SUM(TIMESTAMPDIFF(HOUR, t.fecha_turno, t.fecha_turno)) AS horas_semanales
FROM profesionales prof
INNER JOIN areas_clinicas ac ON prof.id_area = ac.id
INNER JOIN turnos t ON prof.id = t.id_profesional
GROUP BY prof.id, prof.nombre_profesional, ac.nombre_area
ORDER BY horas_semanales DESC;

-- consulta 4
SELECT 
    prof.id AS id_profesional,
    prof.nombre_profesional AS medico_sustituto,
    COUNT(t.id) AS total_turnos_sustituto
FROM profesionales prof
LEFT JOIN turnos t ON prof.id = t.id_profesional
WHERE prof.id_area = 1
GROUP BY prof.id, prof.nombre_profesional
ORDER BY total_turnos_sustituto DESC;

-- consulta 5
SELECT 
    COUNT(DISTINCT t.id_profesional) AS medicos_atendiendo_hoy
FROM turnos t
WHERE t.fecha_turno = CURDATE();

-- consulta 6
SELECT 
    prof.id AS id_profesional,
    prof.nombre_profesional AS medico,
    t.fecha_turno AS dia_consulta,
    1 AS cantidad_turnos
FROM profesionales prof
INNER JOIN turnos t ON prof.id = t.id_profesional
ORDER BY prof.id, t.fecha_turno;

-- consulta 7
SELECT 
    prof.id AS id_profesional,
    prof.nombre_profesional AS medico,
    ac.nombre_area AS especialidad,
    COUNT(DISTINCT t.id_persona) AS total_pacientes
FROM profesionales prof
INNER JOIN areas_clinicas ac ON prof.id_area = ac.id
INNER JOIN turnos t ON prof.id = t.id_profesional
GROUP BY prof.id, prof.nombre_profesional, ac.nombre_area
ORDER BY total_pacientes DESC
LIMIT 1;
