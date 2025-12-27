import 'package:streamingo/modules/clientes/domain/cliente.dart';

class ClienteMapper {
  static Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      name: map['name'],
      telefono: map['telefono'],
      email: map['email'],
      deleted: map['deleted'] == 1 ? true : false,
    );
  }

  static Map<String, dynamic> toMap(Cliente cliente) {
    return {
      'id': cliente.getId,
      'name': cliente.getName.toLowerCase().trim(),
      'telefono': cliente.getTelefono,
      'email': cliente.getEmail,
      'deleted': cliente.getDeleted,
    };
  }
}
