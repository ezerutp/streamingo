import 'package:streamingo/modules/servicios/domain/servicio.dart';

class ServicioMapper {
  static Servicio fromMap(Map<String, dynamic> map) {
    return Servicio(
      id: map['id'],
      nombre: map['nombre'],
      deleted: map['deleted'] == 1 ? true : false,
    );
  }

  static Map<String, dynamic> toMap(Servicio servicio) {
    return {
      'id': servicio.id,
      'nombre': servicio.nombre,
      'deleted': servicio.deleted,
    };
  }
}
