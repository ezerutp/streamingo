import 'package:streamingo/modules/servicios/domain/tipo_servicio.dart';
import 'package:streamingo/modules/servicios/mapper/tipo_servicio_mapper.dart';
import 'package:streamingo/modules/servicios/repo/servicio_repo.dart';
import 'package:streamingo/persistence/db.dart';

class TipoServicioRepository {
  final DatabaseService _databaseService = DatabaseService();
  final ServicioRepository servicioRepository = ServicioRepository();

  // Crear nuevo tipo de servicio
  Future<int> save(TipoServicio tipoServicio) async {
    final db = await _databaseService.database;
    return await db.insert(
      'tipos_servicio',
      TipoServicioMapper.toMap(tipoServicio),
    );
  }

  // Obtener tipo de servicio por ID no eliminado
  Future<TipoServicio?> getById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tipos_servicio',
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
    );

    if (maps.isNotEmpty) {
      final servicio = await servicioRepository.getById(
        maps[0]['servicioId'] as int,
      );
      return TipoServicioMapper.fromMap(maps[0], servicio);
    } else {
      return null;
    }
  }

  // Obtener todos los tipos de servicio no eliminados
  Future<List<TipoServicio>> getAll() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tipos_servicio',
      where: 'deleted = ?',
      whereArgs: [0],
    );

    List<TipoServicio> tipoServicios = [];
    for (var map in maps) {
      final servicio = await servicioRepository.getById(
        map['servicioId'] as int,
      );
      tipoServicios.add(TipoServicioMapper.fromMap(map, servicio));
    }
    return tipoServicios;
  }

  // Obtener solo los tipos de servicio eliminados
  Future<List<TipoServicio>> getDeleted() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tipos_servicio',
      where: 'deleted = ?',
      whereArgs: [1],
    );

    List<TipoServicio> tipoServicios = [];
    for (var map in maps) {
      final servicio = await servicioRepository.getById(
        map['servicioId'] as int,
      );
      tipoServicios.add(TipoServicioMapper.fromMap(map, servicio));
    }
    return tipoServicios;
  }

  // Eliminar tipo de servicio (marcar como eliminado)
  Future<int> delete(TipoServicio tipoServicio) async {
    final db = await _databaseService.database;
    tipoServicio.setDeleted = true;
    return await db.update(
      'tipos_servicio',
      TipoServicioMapper.toMap(tipoServicio),
      where: 'id = ?',
      whereArgs: [tipoServicio.getId],
    );
  }

  // Actualizar tipo de servicio
  Future<int> update(TipoServicio tipoServicio) async {
    final db = await _databaseService.database;
    return await db.update(
      'tipos_servicio',
      TipoServicioMapper.toMap(tipoServicio),
      where: 'id = ?',
      whereArgs: [tipoServicio.getId],
    );
  }
}
