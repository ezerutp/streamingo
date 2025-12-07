class Cliente {
  int? id;
  String name;
  String? telefono;
  String? email;
  bool deleted = false;

  Cliente({
    required this.id,
    required this.name,
    this.telefono,
    this.email,
    this.deleted = false,
  });

  Cliente copyWith({
    int? id,
    String? name,
    String? telefono,
    String? email,
    bool? deleted,
  }) {
    return Cliente(
      id: id ?? this.id,
      name: name ?? this.name,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      deleted: deleted ?? this.deleted,
    );
  }

  int? get getId => id;
  String get getName => name;
  String? get getTelefono => telefono;
  String? get getEmail => email;
  bool get getDeleted => deleted;

  set setId(int? value) => id = value;
  set setName(String value) => name = value;
  set setTelefono(String? value) => telefono = value;
  set setEmail(String? value) => email = value;
  set setDeleted(bool value) => deleted = value;
}
