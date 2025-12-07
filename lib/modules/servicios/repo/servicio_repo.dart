import 'package:streamingo/modules/servicios/domain/servicio.dart';
import 'package:streamingo/modules/servicios/mapper/servicio_mapper.dart';
import 'package:streamingo/persistence/db.dart';

class ServicioRepository {
  final DatabaseService _databaseService = DatabaseService();

  // Crear nuevo servicio
  Future<int> save(Servicio servicio) async {
    final db = await _databaseService.database;
    return await db.insert('servicios', ServicioMapper.toMap(servicio));
  }

  // Obtener servicio por ID no eliminado
  Future<Servicio?> getById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'servicios',
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
    );

    if (maps.isNotEmpty) {
      return ServicioMapper.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Obtener todos los no eliminados
  Future<List<Servicio>> getAll() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'servicios',
      where: 'deleted = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return ServicioMapper.fromMap(maps[i]);
    });
  }

  // Obtener solo los eliminados
  Future<List<Servicio>> getDeleted() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'servicios',
      where: 'deleted = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      return ServicioMapper.fromMap(maps[i]);
    });
  }

  // Eliminar servicio (marcar como eliminado)
  Future<int> delete(Servicio servicio) async {
    final db = await _databaseService.database;
    servicio.setDeleted = true;
    return await db.update(
      'servicios',
      ServicioMapper.toMap(servicio),
      where: 'id = ?',
      whereArgs: [servicio.getId],
    );
  }

  // Actualizar servicio
  Future<int> update(Servicio servicio) async {
    final db = await _databaseService.database;
    return await db.update(
      'servicios',
      ServicioMapper.toMap(servicio),
      where: 'id = ?',
      whereArgs: [servicio.getId],
    );
  }
}
