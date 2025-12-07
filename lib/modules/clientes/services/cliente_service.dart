import 'package:streamingo/modules/clientes/domain/cliente.dart';
import 'package:streamingo/modules/clientes/repo/cliente_repo.dart';

class ClienteService {
  final ClienteRepository clientRepo;

  ClienteService({required this.clientRepo});

  // Obtener todos los clientes
  Future<List<Cliente>> fetchClientes() async {
    return await clientRepo.getAll();
  }

  // Obtener un cliente por ID
  Future<Cliente?> fetchClienteById(int id) async {
    return await clientRepo.getById(id);
  }

  // Crear nuevo cliente
  Future<int> createCliente(Cliente cliente) async {
    return await clientRepo.save(cliente);
  }

  // Eliminar cliente
  Future<int> removeCliente(Cliente cliente) async {
    return await clientRepo.delete(cliente);
  }

  // Actualizar cliente
  Future<int> modifyCliente(Cliente cliente) async {
    return await clientRepo.update(cliente);
  }
}
