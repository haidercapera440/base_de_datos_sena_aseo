# base_de_datos_sena_aseo
DB for SENASEO APP

## Archivos

| Archivo | Descripcion |
|---------|-------------|
| `script_unificado_sena_aseo.sql` | Script unificado de la base de datos (activo) |
| `Analisis_BD_SENA_ASEO.docx` | Analisis de errores y recomendaciones |
| `script_db_juanDavid.sql.bak` | Script original (backup, obsoleto) |
| `sricpt_bd_aseoapp.sql.bak` | Script original (backup, obsoleto) |

## Estructura de la base de datos

### Tablas maestras
- `rol` - Roles del sistema (Administrador, Instructor, Aprendiz)
- `programa_formacion` - Programas del SENA
- `jornada` - Jornadas de formacion
- `nivel_formacion` - Niveles de formacion
- `ambiente` - Ambientes de formacion
- `estado_asistencia` - Estados de asistencia
- `estado_turno` - Estados de turno
- `estado_aseo` - Estados de aseo

### Tablas principales
- `usuario` - Usuarios del sistema (genrica con roles)
- `ficha` - Fichas de aprendizaje
- `instructor` - Instructores (extiende usuario)
- `aprendiz` - Aprendices (extiende usuario)

### Tablas de relacion
- `instructor_ficha` - Relacion instructor-ficha
- `historial_vocero` - Historial de voceria

### Tablas operativas
- `salon` - Salones para sorteo
- `asistencia` - Control de asistencia por aprendiz
- `ciclo_sorteo` - Ciclos de sorteo por aprendiz
- `sorteo` - Sorteos realizados
- `turno_realizado` - Turnos asignados por sorteo
- `turno` - Turnos de aseo programados
- `detalle_turno` - Detalle de turnos

## Uso

```bash
mysql -u root -p < script_unificado_sena_aseo.sql
```

## Correcciones aplicadas

- Unificados dos esquemas en uno solo
- AUTO_INCREMENT en todas las PKs
- Foreign keys con ON DELETE/ON UPDATE
- Contraseñas con hashing (bcrypt en la applicacion)
- Tabla usuario generica con roles
- CHECK constraints para validaciones
- Indices para rendimiento
- Campos de auditoria (created_at, updated_at)
