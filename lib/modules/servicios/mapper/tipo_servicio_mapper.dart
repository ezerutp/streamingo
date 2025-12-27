import 'package:streamingo/modules/servicios/domain/tipo_servicio.dart';

class TipoServicioMapper {
  static TipoServicio fromMap(Map<String, dynamic> map, dynamic servicio) {
    return TipoServicio(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      servicio: servicio,
      precio: map['precio'],
      duracionDias: map['duracionDias'],
      deleted: map['deleted'] == 1 ? true : false,
    );
  }

  static Map<String, dynamic> toMap(TipoServicio tipoServicio) {
    return {
      'id': tipoServicio.getId,
      'nombre': tipoServicio.getNombre,
      'descripcion': tipoServicio.getDescripcion,
      'servicioId': tipoServicio.getServicio.getId,
      'precio': tipoServicio.getPrecio,
      'duracionDias': tipoServicio.getDuracionDias,
      'deleted': tipoServicio.getDeleted,
    };
  }
}
