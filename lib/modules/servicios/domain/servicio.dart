class Servicio {
  int id;
  String nombre;
  String? descripcion;
  String? imagenUrl;
  bool disponible;
  bool deleted = false;

  Servicio({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.imagenUrl,
    required this.disponible,
    this.deleted = false,
  });

  int get getId => id;
  String get getNombre => nombre;
  String? get getDescripcion => descripcion;
  String? get getImagenUrl => imagenUrl;
  bool get isDisponible => disponible;
  bool get getDeleted => deleted;

  set setId(int value) => id = value;
  set setNombre(String value) => nombre = value;
  set setDescripcion(String? value) => descripcion = value;
  set setImagenUrl(String? value) => imagenUrl = value;
  set setDisponible(bool value) => disponible = value;
  set setDeleted(bool value) => deleted = value;
}
