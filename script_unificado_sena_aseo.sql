-- ============================================================
-- BASE DE DATOS UNIFICADA: SENA ASEO APP
-- Fusión de script_db_juanDavid.sql y sricpt_bd_aseoapp.sql
-- Corregida según análisis de errores de sintaxis y diseño
-- ============================================================

DROP DATABASE IF EXISTS sena_aseo;
CREATE DATABASE sena_aseo
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE sena_aseo;

-- ============================================================
-- 1. TABLAS MAESTRAS
-- ============================================================

CREATE TABLE rol (
    id_rol INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE programa_formacion (
    id_programa INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    codigo_programa VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE jornada (
    id_jornada INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE nivel_formacion (
    id_nivel_formacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE ambiente (
    id_ambiente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_numero VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    ubicacion VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE estado_asistencia (
    id_estado_asistencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE estado_turno (
    id_estado_turno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE estado_aseo (
    id_estado_aseo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- 2. TABLAS PRINCIPALES
-- ============================================================

CREATE TABLE usuario (
    id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    n_documento VARCHAR(20) NOT NULL UNIQUE,
    n_telefono VARCHAR(20),
    email_correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    estado_usuario BOOLEAN DEFAULT TRUE,
    id_rol INT UNSIGNED NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol)
        REFERENCES rol(id_rol)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ficha (
    id_ficha INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero_ficha VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    id_programa INT UNSIGNED NOT NULL,
    id_nivel_formacion INT UNSIGNED NOT NULL,
    id_jornada INT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_ficha_fechas CHECK (fecha_inicio < fecha_finalizacion),
    CONSTRAINT fk_ficha_programa
        FOREIGN KEY (id_programa)
        REFERENCES programa_formacion(id_programa)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_ficha_nivel
        FOREIGN KEY (id_nivel_formacion)
        REFERENCES nivel_formacion(id_nivel_formacion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_ficha_jornada
        FOREIGN KEY (id_jornada)
        REFERENCES jornada(id_jornada)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE instructor (
    id_instructor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNSIGNED NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_instructor_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE aprendiz (
    id_aprendiz INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNSIGNED NOT NULL UNIQUE,
    id_ficha INT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_aprendiz_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_aprendiz_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- 3. TABLAS DE RELACIÓN
-- ============================================================

CREATE TABLE instructor_ficha (
    id_instructor INT UNSIGNED NOT NULL,
    id_ficha INT UNSIGNED NOT NULL,
    tipo_instructor ENUM('Lider', 'Transversal') DEFAULT 'Transversal',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_instructor, id_ficha),
    CONSTRAINT fk_if_instructor
        FOREIGN KEY (id_instructor)
        REFERENCES instructor(id_instructor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_if_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE historial_vocero (
    id_historial_vocero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_aprendiz INT UNSIGNED NOT NULL,
    id_ficha INT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE,
    estado_voceria ENUM('Activo', 'Finalizado') DEFAULT 'Activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_hv_aprendiz
        FOREIGN KEY (id_aprendiz)
        REFERENCES aprendiz(id_aprendiz)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_hv_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- 4. TABLAS OPERATIVAS
-- ============================================================

CREATE TABLE salon (
    id_salon INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_salon VARCHAR(40) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE asistencia (
    id_asistencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_aprendiz INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    id_estado_asistencia INT UNSIGNED NOT NULL,
    observacion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_asistencia_aprendiz_fecha UNIQUE (id_aprendiz, fecha),
    CONSTRAINT fk_asistencia_aprendiz
        FOREIGN KEY (id_aprendiz)
        REFERENCES aprendiz(id_aprendiz)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_asistencia_estado
        FOREIGN KEY (id_estado_asistencia)
        REFERENCES estado_asistencia(id_estado_asistencia)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE ciclo_sorteo (
    id_ciclo_sorteo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_aprendiz INT UNSIGNED NOT NULL,
    id_ficha INT UNSIGNED NOT NULL,
    id_estado_aseo INT UNSIGNED NOT NULL DEFAULT 2,
    ciclo INT UNSIGNED NOT NULL DEFAULT 0,
    realizado TINYINT NOT NULL DEFAULT 2,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_ciclo_aprendiz_ficha UNIQUE (id_aprendiz, id_ficha),
    CONSTRAINT fk_cs_aprendiz
        FOREIGN KEY (id_aprendiz)
        REFERENCES aprendiz(id_aprendiz)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_cs_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_cs_estado_aseo
        FOREIGN KEY (id_estado_aseo)
        REFERENCES estado_aseo(id_estado_aseo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE sorteo (
    id_sorteo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cantidad_sorteada INT UNSIGNED NOT NULL,
    id_salon INT UNSIGNED NOT NULL,
    id_ficha INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_sorteo_salon
        FOREIGN KEY (id_salon)
        REFERENCES salon(id_salon)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_sorteo_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE turno_realizado (
    id_turno_realizado INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_sorteo INT UNSIGNED NOT NULL,
    id_aprendiz INT UNSIGNED NOT NULL,
    id_estado_aseo INT UNSIGNED NOT NULL DEFAULT 2,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_turno_sorteo_aprendiz UNIQUE (id_sorteo, id_aprendiz),
    CONSTRAINT fk_tr_sorteo
        FOREIGN KEY (id_sorteo)
        REFERENCES sorteo(id_sorteo)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_tr_aprendiz
        FOREIGN KEY (id_aprendiz)
        REFERENCES aprendiz(id_aprendiz)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_tr_estado_aseo
        FOREIGN KEY (id_estado_aseo)
        REFERENCES estado_aseo(id_estado_aseo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE turno (
    id_turno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_ficha INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    id_ambiente INT UNSIGNED NOT NULL,
    id_usuario INT UNSIGNED NOT NULL,
    observacion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_turno_ficha
        FOREIGN KEY (id_ficha)
        REFERENCES ficha(id_ficha)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_turno_ambiente
        FOREIGN KEY (id_ambiente)
        REFERENCES ambiente(id_ambiente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_turno_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE detalle_turno (
    id_detalle_turno INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_turno INT UNSIGNED NOT NULL,
    id_asistencia INT UNSIGNED NOT NULL,
    id_estado_turno INT UNSIGNED NOT NULL DEFAULT 3,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_detalle_turno_asistencia UNIQUE (id_turno, id_asistencia),
    CONSTRAINT fk_dt_turno
        FOREIGN KEY (id_turno)
        REFERENCES turno(id_turno)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dt_asistencia
        FOREIGN KEY (id_asistencia)
        REFERENCES asistencia(id_asistencia)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dt_estado
        FOREIGN KEY (id_estado_turno)
        REFERENCES estado_turno(id_estado_turno)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- 5. ÍNDICES PARA RENDIMIENTO
-- ============================================================

CREATE INDEX idx_aprendiz_ficha ON aprendiz(id_ficha);
CREATE INDEX idx_asistencia_fecha ON asistencia(fecha);
CREATE INDEX idx_asistencia_estado ON asistencia(id_estado_asistencia);
CREATE INDEX idx_turno_fecha ON turno(fecha);
CREATE INDEX idx_turno_ficha ON turno(id_ficha);
CREATE INDEX idx_historial_vocero ON historial_vocero(id_ficha, id_aprendiz);
CREATE INDEX idx_ciclo_sorteo_ficha ON ciclo_sorteo(id_ficha);
CREATE INDEX idx_ciclo_sorteo_realizado ON ciclo_sorteo(realizado);
CREATE INDEX idx_sorteo_ficha ON sorteo(id_ficha);
CREATE INDEX idx_turno_realizado_aprendiz ON turno_realizado(id_aprendiz);
CREATE INDEX idx_detalle_turno_turno ON detalle_turno(id_turno);
CREATE INDEX idx_usuario_rol ON usuario(id_rol);
CREATE INDEX idx_ficha_programa ON ficha(id_programa);

-- ============================================================
-- 6. DATOS INICIALES (DATOS MAESTROS)
-- ============================================================

INSERT INTO rol (nombre) VALUES
('Administrador'),
('Instructor'),
('Aprendiz');

INSERT INTO jornada (descripcion) VALUES
('Manana'),
('Tarde'),
('Noche'),
('Fin de Semana'),
('Mixta');

INSERT INTO nivel_formacion (descripcion) VALUES
('Tecnologo'),
('Tecnico'),
('Auxiliar'),
('Operario'),
('Cursos Especiales'),
('Cursos Complementarios Cortos');

INSERT INTO estado_asistencia (descripcion) VALUES
('Asistio'),
('No asistio'),
('Pendiente'),
('Excusa'),
('Retiro Temprano');

INSERT INTO estado_turno (descripcion) VALUES
('Cumplio'),
('Evadio'),
('Pendiente');

INSERT INTO estado_aseo (descripcion) VALUES
('Realizado'),
('No realizado');

INSERT INTO programa_formacion (nombre, codigo_programa) VALUES
('Analisis y Desarrollo de Software', 'ADSO'),
('Tecnico en Electricidad', 'ELEC'),
('Auxiliar en Enfermeria', 'ENF'),
('Tecnologo en Contabilidad', 'CONT'),
('Operario en Cargas Pesadas', 'CARG');

-- ============================================================
-- 7. TRIGGERS
-- ============================================================

DELIMITER $$

-- Trigger: Al crear un usuario con rol Instructor, crear registro en instructor
CREATE TRIGGER trg_usuario_instructor
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    IF NEW.id_rol = 2 THEN
        INSERT INTO instructor (id_usuario)
        VALUES (NEW.id_usuario);
    END IF;
END$$

-- Trigger: Al crear un usuario con rol Aprendiz, crear registro en aprendiz
CREATE TRIGGER trg_usuario_aprendiz
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    IF NEW.id_rol = 3 THEN
        INSERT INTO aprendiz (id_usuario)
        VALUES (NEW.id_usuario);
    END IF;
END$$

-- Trigger: Al insertar asistencia, crear registros en ciclo_sorteo para aprendices nuevos
CREATE TRIGGER trg_asistencia_poblar_ciclo
AFTER INSERT ON asistencia
FOR EACH ROW
BEGIN
    INSERT IGNORE INTO ciclo_sorteo (id_aprendiz, id_ficha, id_estado_aseo, ciclo)
    SELECT NEW.id_aprendiz, a.id_ficha, 2, 0
    FROM aprendiz a
    WHERE a.id_aprendiz = NEW.id_aprendiz;
END$$

DELIMITER ;

-- ============================================================
-- 8. PROCEDURES
-- ============================================================

DELIMITER $$

-- Procedure: Crear usuario completo (instructor o aprendiz)
CREATE PROCEDURE sp_crear_usuario(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_n_documento VARCHAR(20),
    IN p_n_telefono VARCHAR(20),
    IN p_email VARCHAR(150),
    IN p_contrasena VARCHAR(255),
    IN p_id_rol INT UNSIGNED,
    IN p_id_ficha INT UNSIGNED,
    IN p_tipo_instructor VARCHAR(11)
)
BEGIN
    DECLARE v_id_usuario INT UNSIGNED;
    DECLARE v_id_instructor INT UNSIGNED;

    INSERT INTO usuario (
        nombres, apellidos, n_documento, n_telefono,
        email_correo, contrasena, id_rol
    ) VALUES (
        p_nombres, p_apellidos, p_n_documento, p_n_telefono,
        p_email, p_contrasena, p_id_rol
    );

    SET v_id_usuario = LAST_INSERT_ID();

    IF p_id_rol = 3 AND p_id_ficha IS NOT NULL THEN
        UPDATE aprendiz
        SET id_ficha = p_id_ficha
        WHERE id_usuario = v_id_usuario;
    END IF;

    IF p_id_rol = 2 AND p_id_ficha IS NOT NULL THEN
        SELECT id_instructor INTO v_id_instructor
        FROM instructor
        WHERE id_usuario = v_id_usuario;

        INSERT INTO instructor_ficha (id_instructor, id_ficha, tipo_instructor)
        VALUES (v_id_instructor, p_id_ficha, p_tipo_instructor);
    END IF;
END$$

-- Procedure: Realizar sorteo de aseo
CREATE PROCEDURE sp_realizar_sorteo(
    IN p_id_ficha INT UNSIGNED,
    IN p_id_salon INT UNSIGNED,
    IN p_cantidad INT UNSIGNED
)
BEGIN
    DECLARE v_pendientes INT;
    DECLARE v_id_sorteo INT UNSIGNED;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Verificar cuantos aprendices pendientes hay
    SELECT COUNT(*) INTO v_pendientes
    FROM ciclo_sorteo
    WHERE id_ficha = p_id_ficha
      AND realizado = 2;

    -- Si no hay pendientes, resetear el ciclo
    IF v_pendientes = 0 THEN
        UPDATE ciclo_sorteo
        SET realizado = 2,
            ciclo = ciclo + 1
        WHERE id_ficha = p_id_ficha;
    END IF;

    -- Crear registro del sorteo
    INSERT INTO sorteo (cantidad_sorteada, id_salon, id_ficha)
    VALUES (p_cantidad, p_id_salon, p_id_ficha);
    SET v_id_sorteo = LAST_INSERT_ID();

    -- Seleccionar aprendices sorteados aleatoriamente
    INSERT INTO turno_realizado (id_sorteo, id_aprendiz, id_estado_aseo)
    SELECT v_id_sorteo, cs.id_aprendiz, 2
    FROM ciclo_sorteo cs
    WHERE cs.id_ficha = p_id_ficha
      AND cs.realizado = 2
    ORDER BY RAND()
    LIMIT p_cantidad;

    -- Marcar como realizado
    UPDATE ciclo_sorteo cs
    INNER JOIN turno_realizado tr ON cs.id_aprendiz = tr.id_aprendiz
    SET cs.realizado = 1
    WHERE cs.id_ficha = p_id_ficha
      AND tr.id_sorteo = v_id_sorteo;

    COMMIT;

    -- Retornar los sorteados
    SELECT
        a.id_aprendiz,
        u.nombres,
        u.apellidos,
        cs.ciclo,
        s.nombre_salon,
        'Sorteado' AS estado_sorteo
    FROM turno_realizado tr
    INNER JOIN aprendiz a ON tr.id_aprendiz = a.id_aprendiz
    INNER JOIN usuario u ON a.id_usuario = u.id_usuario
    INNER JOIN ciclo_sorteo cs ON cs.id_aprendiz = a.id_aprendiz AND cs.id_ficha = p_id_ficha
    INNER JOIN salon s ON s.id_salon = p_id_salon
    WHERE tr.id_sorteo = v_id_sorteo;
END$$

DELIMITER ;

-- ============================================================
-- 9. DATOS DE PRUEBA
-- ============================================================

-- Crear instructores
CALL sp_crear_usuario('Jose', 'Alfonso', '11305904', '3001009988', 'jalfonso@gmail.com', '$2a$10$hashed_password_1', 2, NULL, NULL);
CALL sp_crear_usuario('Maria', 'Lopez', '10987654', '3101234567', 'maria.lopez@gmail.com', '$2a$10$hashed_password_2', 2, NULL, NULL);

-- Crear fichas
INSERT INTO ficha (numero_ficha, nombre, id_programa, id_nivel_formacion, id_jornada, fecha_inicio, fecha_finalizacion) VALUES
('213', 'Tecnico en Electricidad', 2, 2, 2, '2026-04-30', '2026-11-30'),
('222', 'Auxiliar en Enfermeria', 3, 3, 3, '2026-04-30', '2026-09-30'),
('231', 'Tecnologo en Contabilidad', 4, 1, 1, '2026-04-30', '2027-04-30'),
('3238063', 'Analisis y Desarrollo de Software', 1, 1, 1, '2026-04-30', '2027-04-30'),
('432', 'Operario en Cargas Pesadas', 5, 4, 5, '2026-04-30', '2026-08-30');

-- Asignar instructores a fichas
INSERT INTO instructor_ficha (id_instructor, id_ficha, tipo_instructor)
SELECT i.id_instructor, f.id_ficha, 'Lider'
FROM instructor i
CROSS JOIN ficha f
WHERE i.id_usuario IN (SELECT id_usuario FROM usuario WHERE email_correo = 'jalfonso@gmail.com')
  AND f.numero_ficha = '3238063';

-- Crear aprendices
CALL sp_crear_usuario('Daniel', 'Andrade', '1010135940', '3015649852', 'daniel.andrade@gmail.com', '$2a$10$hashed_password_3', 3, NULL, NULL);
CALL sp_crear_usuario('Juan', 'Martinez', '1070585723', '3105678954', 'juan.martinez@gmail.com', '$2a$10$hashed_password_4', 3, NULL, NULL);
CALL sp_crear_usuario('Haider', 'Capera', '1070587388', '3154786985', 'jose.capera@hotmail.com', '$2a$10$hashed_password_5', 3, NULL, NULL);

-- Asignar aprendices a ficha ADSO
UPDATE aprendiz SET id_ficha = (SELECT id_ficha FROM ficha WHERE numero_ficha = '3238063')
WHERE id_usuario IN (SELECT id_usuario FROM usuario WHERE n_documento IN ('1010135940', '1070585723', '1070587388'));

-- Crear salones
INSERT INTO salon (nombre_salon) VALUES
('Salon 101'),
('Salon 102'),
('Salon 201');

-- Crear ambientes
INSERT INTO ambiente (nombre_numero, descripcion, ubicacion) VALUES
('A101', 'Ambiente de formacion 101', 'Piso 1'),
('A102', 'Ambiente de formacion 102', 'Piso 1'),
('A201', 'Ambiente de formacion 201', 'Piso 2');

-- ============================================================
-- FIN DEL SCRIPT UNIFICADO
-- ============================================================
