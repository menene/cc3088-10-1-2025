
Table estudiantes {
  id Int [pk]
  carnet Int [not null]
  nombre varchar [not null]
}

Table actividades {
  id Int [pk]
  nombre Varchar [not null]
  fecha timestamp [not null]
}

Table calificaciones {
  id Int [pk]
  estudiente_id Int [ref: > estudiantes.id]
  actividad_id Int [ref: > actividades.id]
  nota Float [not null]
  fecha timestamp [not null]
}