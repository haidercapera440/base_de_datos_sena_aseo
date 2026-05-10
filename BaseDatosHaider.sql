################################ BASE DE DATOS DEL  SENA ASEO PARA LOS FLOJOS ######################################
#### COMENTARIOS ####
#1/05/2026 se insertaron las tablas usuario, Instructor, Ambiente, Jornada, sede, ficha, instructor_ficha, aprendiz, estado, 
#fechaasistencia, asistencia.
#2/05/2026 Se termino de ingresar los datos a todas las tablas 
### PENDIENTES ###
# ninguno que afecte la funcionalidad (revisar la tabla Ganadores ya que puede repetir el aprendis en una misma fecha)

###### INSERTAR INFORMACION A LAS TABLAS #######

#### COLUMNA USUARIO ###
INSERT INTO usuario
(idusuario, Nombre, Apellido, ntelefono)
values
(29, 'alberto', 'perez', '3245672343'),
(31, 'julian', 'gomez', '3422135674'),
(33, 'jhon', 'martinez', '3124567890'),
(32, 'pedro', 'arias', '3673218976');

################## INSTRUCTOR ########################### Tabla Principal
INSERT INTO instructor 
(IdInstructor, contraseña)
values
(29, '123456'), #jornada Noche del ambiente 129 de la sede tecnologia y diseño
(31, '123456'), #jordada Tarde del ambiente 131 de la sede centro
(32, '123456'), #jornada Mañana del ambiente 132 de la sede tecnologia y diseño
(33, '123456'); #jornada Noche del ambiente 133 de la sede cetro
##################### AMBIENTE ################ tabla secundaria
INSERT INTO ambiente
(idAmbiente,NombreAmbiente)
values 
(129,'AmbienteAlberto'),
(131,'AmbienteJulian'),
(132,'AmbienteJhon'),
(133,'AmbientePedro');
################### Jornada ################## tabla secundaria
INSERT INTO jornada
(idJornada, TipoJornada)
values 
(1, 'Mañana'),
(2, 'Tarde'),
(3, 'Noche');
################# SEDE #################### tabla secundaria
INSERT INTO sede 
(idSede, NombreSede)
values
(10, 'sede centro'),
(11, 'sede Tecnologia y Diseño');
################ Ficha ################### Tabla Pricipal
INSERT INTO ficha 
(ID_Ficha, Jornada, Ambiente, Fecha_inicio, Fecha_Finaliazcion, Nombre_Ficha, Sede)
values
(3238063, 3, 129, '2026-05-25', '2027-10-25', 'ADSO', 11 ),
(2834987, 2, 131, '2026-05-25', '2027-10-25', 'Multimedia', 10 ),
(5637893, 1, 132, '2026-05-25', '2027-10-25', 'TopoGrafia', 11 ),
(3456763, 3, 133, '2026-05-25', '2027-10-25', 'Administracion empresas', 10 );

#instructor 29 jornada Noche del ambiente 129 de la sede tecnologia y diseño
# instructor 31 jordada Tarde del ambiente 131 de la sede centro
# instructor 32 jornada Mañana del ambiente 132 de la sede tecnologia y diseño
#instructor 33 jornada Noche del ambiente 133 de la sede cetro

################ INSTRUCTOR - FICHA ##################### Tabla intermedia donde se asigna el instructor con su ficha 
INSERT INTO instructor_ficha
(Instructor, Ficha)
values 
(29,323803);
###################### APRENDIZ ######################### Tabla Principal
INSERT INTO aprendiz 
(idaprendiz, Ficha, Nombre, Apellido, ntelefono)
values
(1070587388, 3238063, 'haider fernando', 'capera devia', '3012099550'), #adso
(1070567399, 3238063, 'carlos andres', 'capera devia', '3502345678'),#adso
(1078456789, 3238063, 'maria paula', 'velez', '3214567892'),#adso
(1056789234, 3238063, 'liset ', 'mendoza', '3456789012'),#adso

(1058345671, 2834987, 'manuel', 'aragon', '3673451122'),#Multimedia
(1978456234, 2834987, 'kevin', 'garzon', '3489123456'),#Multimedia
(1234532112, 2834987, 'jose', 'mendez', '3673451122'),#Multimedia
(1098345321, 2834987, 'julian', 'derecho', '3784982134'),#Multimedia

(1784623678, 5637893, 'jhoan', 'vargas', '3909023456'),#TopoGrafia
(1678901907, 5637893, 'brayan', 'gomez', '3783002001'),#TopoGrafia
(1905678432, 5637893, 'fabian', 'largo', '3456732134'),#TopoGrafia
(1789399344, 5637893, 'valentina', 'beltran', '3772556788'),#TopoGrafia

(1055876265, 3456763, 'valeria', 'orguela', '3567345233'),#Administracion empresas
(1049434442, 3456763, 'gina', 'arias', '3663773930'),#Administracion empresas
(1056388299, 3456763, 'yoany', 'herrera diaz', '3996669900'),#Administracion empresas
(1645902567, 3456763, 'jaime', 'perez', '3892337729');#Administracion empresas

################################### ESTADO DE ASISTENCIA ################################## Tabla Secundaria
INSERT INTO estado
(idEstado, DescripcionEstado)
values
(01, 'No Asistio'),
(02, 'Asistio');
################################# Fecha Asitencia ######################################## Tabla secundaria 
INSERT INTO fechaasistencia 
(idfechaAsitencia, Fecha)
values
(30, '2026-04-30'),
(1, '2026-05-30');
################################# Asistencia ############################################## tabla Principal
INSERT INTO asistencia 
(id_Aprendiz_asistencia, Id_Estado, Aprendiz, Ficha)
values
(30, 02, 1070587388, 3238063), #aprendiz haider asistio el dia 30/04/2026 de la ficha 3238063 adso
(30, 01, 1070567399, 3238063),
(30, 02, 1078456789, 3238063),
(30, 02, 1056789234, 3238063),
(30, 02, 1058345671, 2834987),
(30, 02, 1978456234, 2834987),
(30, 02, 1234532112, 2834987),
(30, 02, 1098345321, 2834987),
(30, 02, 1784623678, 5637893),
(30, 02, 1678901907, 5637893),
(30, 02, 1905678432, 5637893),
(30, 02, 1789399344, 5637893),
(30, 02, 1055876265, 3456763),
(30, 02, 1049434442, 3456763),
(30, 02, 1056388299, 3456763),
(30, 02, 1645902567, 3456763),
#siguiente fecha
(1, 02, 1070587388, 3238063), #aprendiz haider asistio el dia 01/05/2026 de la ficha 3238063 adso
(1, 01, 1070567399, 3238063),
(1, 02, 1078456789, 3238063),
(1, 01, 1056789234, 3238063),
(1, 02, 1058345671, 2834987),
(1, 01, 1978456234, 2834987),
(1, 02, 1234532112, 2834987),
(1, 02, 1098345321, 2834987),
(1, 01, 1784623678, 5637893),
(1, 02, 1678901907, 5637893),
(1, 01, 1905678432, 5637893),
(1, 02, 1789399344, 5637893),
(1, 02, 1055876265, 3456763),
(1, 01, 1049434442, 3456763),
(1, 02, 1056388299, 3456763),
(1, 02, 1645902567, 3456763);
##################################### EXPERIMENTO ##############################################
########################CREACION DE LA TABLA GANADORES SORTEO ######################
use  senaaseo;
CREATE TABLE GanadoreSorteo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  FechaAsistencia INT NOT NULL,
  Nambiente INT NOT NULL,
  MensajeLimpieza INT NOT NULL,
  Aprendiz BIGINT NOT NULL,

  INDEX (MensajeLimpieza),
  INDEX (Nambiente),
  INDEX (FechaAsistencia),
  INDEX (Aprendiz),

  CONSTRAINT GanadorMensaje
    FOREIGN KEY (MensajeLimpieza)
    REFERENCES mensaje_limpieza (Id_Mensaje_Limpiesa),

  CONSTRAINT GanadorAmbiente
    FOREIGN KEY (Nambiente)
    REFERENCES ambiente (idAmbiente),

  CONSTRAINT GanadorAsistencia
    FOREIGN KEY (FechaAsistencia)
    REFERENCES fechaasistencia (idfechaAsitencia)
);
######################################### CONSULTAS ##############################
-- drop table ganadoresorteo;
##################### APRENDICES ############
select *  from aprendiz;
##################### USUARIOS (instructores) ###############
SELECT * FROM usuario;
##################### INSTRUCTORES (ID - CONTRASEÑA ) ###################
select
	ap.Nombre,
    ap.Apellido,
    contraseña
from instructor j
	join usuario ap
    on j.IdInstructor = ap.idusuario;
    
################### FICHA #######################
#select * from ficha;
select 
ID_Ficha,
j.TipoJornada,
n.NombreAmbiente,
Fecha_inicio,
Fecha_Finaliazcion,
Nombre_Ficha,
s.NombreSede
from ficha f

join jornada j
on f.Jornada = j.idJornada

join ambiente n
on f.Ambiente = n.idAmbiente

join sede s
on f.Sede = s.idSede;

    
###################### GANADORES SORTEO ##############################
SELECT 
  g.id,
  f.Fecha,
  a.NombreAmbiente,
  m.Descrpcion,  
  ap.Nombre,
  ap.Apellido,
  g.FichaGanador
FROM GanadoreSorteo g

JOIN fechaasistencia f 
  ON g.FechaAsistencia = f.idfechaAsitencia

JOIN ambiente a 
  ON g.Nambiente = a.idAmbiente

JOIN mensaje_limpieza m 
  ON g.MensajeLimpieza = m.Id_Mensaje_Limpiesa

JOIN aprendiz ap 
  ON g.Aprendiz = ap.idaprendiz

where g.FechaAsistencia = 30 and g.FichaGanador = 3238063;
################################ ASISTENCIA ########################################

SELECT 
  fa.Fecha,
  e.DescripcionEstado,
  ap.Nombre,
  ap.Apellido,
  f.Nombre_Ficha,
  am.NombreAmbiente

FROM asistencia a

JOIN fechaasistencia fa 
  ON a.id_Aprendiz_asistencia = fa.idfechaAsitencia

JOIN estado e 
  ON a.Id_Estado = e.idEstado

JOIN aprendiz ap 
  ON a.Aprendiz = ap.idaprendiz

JOIN ficha f 
  ON a.Ficha = f.ID_Ficha

JOIN ambiente am 
  ON f.Ambiente = am.idAmbiente

where a.Ficha = 3238063 and a.id_Aprendiz_asistencia = 30 and a.Id_Estado = 2;
###################################### INSERTAR TABLA GANADORES SORTEO ############################
INSERT INTO mensaje_limpieza
(Id_Mensaje_Limpiesa, Descrpcion )
values
(00, 'HECHO SIN NOVEDADES'),
(11, 'HECHO CON NOVEDADES'),
(22, 'NO REALIZADO');




INSERT INTO ganadoresorteo
(FechaAsistencia, Nambiente, MensajeLimpieza, Aprendiz, FichaGanador)
values
(30, 129, 00, 1070587388, 3238063), # PRUEBA
(30, 129, 00, 1078456789, 3238063), #ADSO
(30, 131, 11, 1058345671, 2834987),#MULTIMEDIA
(30, 131, 11, 1978456234, 2834987), #MULTIMEDIA
(30, 132, 22, 1784623678, 5637893), #TOPOGRAFIA
(30, 132, 22, 1678901907, 5637893),#TOPOGRAFIA
(30, 133, 00, 1055876265, 3456763),#ADMISTRACION
(30, 133, 00, 1645902567, 3456763),#ADMINISTRACIO
#SEGUNDA FECHA
(1, 129, 00, 1070587388, 3238063), # PRUEBA
(1, 129, 00, 1078456789, 3238063), #ADSO
(1, 131, 11, 1234532112, 2834987),#MULTIMEDIA
(1, 131, 11, 1098345321, 2834987), #MULTIMEDIA
(1, 132, 22, 1789399344, 5637893), #TOPOGRAFIA
(1, 132, 22, 1678901907, 5637893),#TOPOGRAFIA
(1, 133, 00, 1056388299, 3456763),#ADMISTRACION
(1, 133, 00, 1645902567, 3456763);#ADMINISTRACIO