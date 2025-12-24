import 'package:streamingo/modules/clientes/repo/cliente_repo.dart';
import 'package:streamingo/modules/servicios/repo/tipo_servicio_repo.dart';
import 'package:streamingo/modules/venta/domain/venta.dart';
import 'package:streamingo/modules/venta/mapper/venta_mapper.dart';
import 'package:streamingo/persistence/db.dart';

class VentaRepository {
  final DatabaseService _databaseService = DatabaseService();
  final ClienteRepository clienteRepository = ClienteRepository();
  final TipoServicioRepository tipoServicioRepository =
      TipoServicioRepository();

  // Crear nueva venta
  Future<int> save(Venta venta) async {
    final db = await _databaseService.database;
    return await db.insert('ventas', VentaMapper.toMap(venta));
  }

  // Obtener venta por ID no eliminada
  Future<Venta?> getById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ventas',
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
    );

    if (maps.isNotEmpty) {
      final cliente = await clienteRepository.getById(
        maps[0]['clienteId'] as int,
      );
      final tipoServicio = await tipoServicioRepository.getById(
        maps[0]['tipoServicioId'] as int,
      );
      return VentaMapper.fromMap(maps.first, cliente, tipoServicio);
    } else {
      return null;
    }
  }

  // Obtener todas las ventas no eliminadas
  Future<List<Venta>> getVentasActivas() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ventas',
      where: 'deleted = ? and cancelado = ?',
      whereArgs: [0, 0],
    );

    List<Venta> ventas = [];
    for (var map in maps) {
      final cliente = await clienteRepository.getById(map['clienteId'] as int);
      final tipoServicio = await tipoServicioRepository.getById(
        map['tipoServicioId'] as int,
      );
      ventas.add(VentaMapper.fromMap(map, cliente, tipoServicio));
    }
    return ventas;
  }

  // Obtener solo las ventas eliminadas
  Future<List<Venta>> getDeleted() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ventas',
      where: 'deleted = ?',
      whereArgs: [1],
    );

    List<Venta> ventas = [];
    for (var map in maps) {
      final cliente = await clienteRepository.getById(map['clienteId'] as int);
      final tipoServicio = await tipoServicioRepository.getById(
        map['tipoServicioId'] as int,
      );
      ventas.add(VentaMapper.fromMap(map, cliente, tipoServicio));
    }
    return ventas;
  }

  // Eliminar venta (marcar como eliminado)
  Future<int> delete(Venta venta) async {
    final db = await _databaseService.database;
    venta.setDeleted = true;
    return await db.update(
      'ventas',
      VentaMapper.toMap(venta),
      where: 'id = ?',
      whereArgs: [venta.getId],
    );
  }

  // Cancelar venta
  Future<int> cancel(Venta venta) async {
    final db = await _databaseService.database;
    venta.setCancelado = true;
    return await db.update(
      'ventas',
      VentaMapper.toMap(venta),
      where: 'id = ?',
      whereArgs: [venta.getId],
    );
  }

  // Actualizar venta
  Future<int> update(Venta venta) async {
    final db = await _databaseService.database;
    return await db.update(
      'ventas',
      VentaMapper.toMap(venta),
      where: 'id = ?',
      whereArgs: [venta.getId],
    );
  }
}
