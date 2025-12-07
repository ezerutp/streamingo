import 'package:streamingo/modules/clientes/domain/cliente.dart';

class ClienteMapper {
  static Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as int,
      name: map['name'] as String,
      telefono: map['telefono'] as String?,
      email: map['email'] as String?,
      deleted: map['deleted'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toMap(Cliente cliente) {
    return {
      'id': cliente.getId,
      'name': cliente.getName,
      'telefono': cliente.getTelefono,
      'email': cliente.getEmail,
      'deleted': cliente.getDeleted,
    };
  }
}
