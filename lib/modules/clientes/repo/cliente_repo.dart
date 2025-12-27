import 'package:streamingo/modules/clientes/domain/cliente.dart';
import 'package:streamingo/modules/clientes/mapper/cliente_mapper.dart';
import 'package:streamingo/persistence/db.dart';

class ClienteRepository {
  final DatabaseService _databaseService = DatabaseService();

  // Crear nuevo cliente
  Future<int> save(Cliente cliente) async {
    final db = await _databaseService.database;
    return await db.insert('clientes', ClienteMapper.toMap(cliente));
  }

  // Obtener cliente por ID no eliminado
  Future<Cliente?> getById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'clientes',
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
    );

    if (maps.isNotEmpty) {
      return ClienteMapper.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Obtener todos los no eliminados
  Future<List<Cliente>> getAll() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'clientes',
      where: 'deleted = ?',
      orderBy: 'name ASC',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return ClienteMapper.fromMap(maps[i]);
    });
  }

  //Obtener solo los eliminados
  Future<List<Cliente>> getDeleted() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'clientes',
      where: 'deleted = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      return ClienteMapper.fromMap(maps[i]);
    });
  }

  // Eliminar cliente (marcar como eliminado)
  Future<int> delete(Cliente cliente) async {
    final db = await _databaseService.database;
    cliente.setDeleted = true;
    return await db.update(
      'clientes',
      ClienteMapper.toMap(cliente),
      where: 'id = ?',
      whereArgs: [cliente.getId],
    );
  }

  // Actualizar cliente
  Future<int> update(Cliente cliente) async {
    final db = await _databaseService.database;
    return await db.update(
      'clientes',
      ClienteMapper.toMap(cliente),
      where: 'id = ?',
      whereArgs: [cliente.getId],
    );
  }
}
