class Servicio {
  int? id;
  String nombre;
  bool deleted = false;

  Servicio({required this.id, required this.nombre, this.deleted = false});

  Servicio copyWith({int? id, String? nombre, bool? deleted}) {
    return Servicio(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      deleted: deleted ?? this.deleted,
    );
  }

  int? get getId => id;
  String get getNombre => nombre;
  bool get getDeleted => deleted;

  set setId(int? value) => id = value;
  set setNombre(String value) => nombre = value;
  set setDeleted(bool value) => deleted = value;
}
