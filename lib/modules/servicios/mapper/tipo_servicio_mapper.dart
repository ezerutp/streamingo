import 'package:streamingo/modules/servicios/domain/tipo_servicio.dart';

class TipoServicioMapper {
  static TipoServicio fromMap(Map<String, dynamic> map, dynamic servicio) {
    return TipoServicio(
      id: map['id'] as int,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String?,
      servicio: servicio,
      precio: map['precio'] as double,
      duracionDias: map['duracionDias'] as int,
      deleted: map['deleted'] as bool? ?? false,
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
