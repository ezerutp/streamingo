import 'package:streamingo/modules/servicios/domain/servicio.dart';

class TipoServicio {
  int? id;
  String nombre;
  String? descripcion;
  Servicio servicio;
  double precio;
  int duracionDias; // duración en días
  bool deleted = false;

  TipoServicio({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.servicio,
    required this.precio,
    required this.duracionDias,
    this.deleted = false,
  });

  TipoServicio copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    Servicio? servicio,
    double? precio,
    int? duracionDias,
    bool? deleted,
  }) {
    return TipoServicio(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      servicio: servicio ?? this.servicio,
      precio: precio ?? this.precio,
      duracionDias: duracionDias ?? this.duracionDias,
      deleted: deleted ?? this.deleted,
    );
  }

  int? get getId => id;
  String get getNombre => nombre;
  String? get getDescripcion => descripcion;
  Servicio get getServicio => servicio;
  double get getPrecio => precio;
  int get getDuracionDias => duracionDias;
  bool get getDeleted => deleted;

  set setId(int? value) => id = value;
  set setNombre(String value) => nombre = value;
  set setDescripcion(String? value) => descripcion = value;
  set setServicio(Servicio value) => servicio = value;
  set setPrecio(double value) => precio = value;
  set setDuracionDias(int value) => duracionDias = value;
  set setDeleted(bool value) => deleted = value;
}
