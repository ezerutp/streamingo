import 'package:streamingo/modules/servicios/domain/servicio.dart';

class ServicioMapper {
  static Servicio fromMap(Map<String, dynamic> map) {
    return Servicio(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String?,
      imagenUrl: map['imagenUrl'] as String?,
      disponible: map['disponible'] as bool,
      deleted: map['deleted'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toMap(Servicio servicio) {
    return {
      'id': servicio.id,
      'nombre': servicio.nombre,
      'descripcion': servicio.descripcion,
      'imagenUrl': servicio.imagenUrl,
      'disponible': servicio.disponible,
      'deleted': servicio.deleted,
    };
  }
}
