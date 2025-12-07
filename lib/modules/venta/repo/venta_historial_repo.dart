import 'package:streamingo/modules/venta/domain/venta_historial.dart';
import 'package:streamingo/modules/venta/mapper/venta_historial_mapper.dart';
import 'package:streamingo/modules/venta/repo/venta_repo.dart';
import 'package:streamingo/persistence/db.dart';

class VentaHistorialRepository {
  final DatabaseService _databaseService = DatabaseService();
  final VentaRepository ventaRepository = VentaRepository();

  // Crear nuevo historial de venta
  Future<int> save(VentaHistorico ventaHistorial) async {
    final db = await _databaseService.database;
    return await db.insert(
      'venta_historial',
      VentaHistoricoMapper.toMap(ventaHistorial),
    );
  }

  // Obtener historial de venta por ID
  Future<VentaHistorico?> getById(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'venta_historial',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final venta = await ventaRepository.getById(maps[0]['ventaId'] as int);
      return VentaHistoricoMapper.fromMap(maps.first, venta);
    } else {
      return null;
    }
  }

  // Obtener todos los historiales de venta
  Future<List<VentaHistorico>> getAll() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('venta_historial');
    List<VentaHistorico> ventaHistoriales = [];
    for (var map in maps) {
      final venta = await ventaRepository.getById(map['ventaId'] as int);
      ventaHistoriales.add(VentaHistoricoMapper.fromMap(map, venta));
    }
    return ventaHistoriales;
  }

  // Obtener todos los historiales de venta de un mes específico
  Future<List<VentaHistorico>> getByMonth(DateTime date) async {
    final db = await _databaseService.database;
    final String monthStr = date.month.toString().padLeft(2, '0');
    final String startDate = '${date.year}-$monthStr-01';
    final String endDate =
        date.month < 12
            ? '${date.year}-${(date.month + 1).toString().padLeft(2, '0')}-01'
            : '${date.year + 1}-01-01';

    final List<Map<String, dynamic>> maps = await db.query(
      'venta_historial',
      where: 'fechaPago >= ? AND fechaPago < ?',
      whereArgs: [startDate, endDate],
    );

    List<VentaHistorico> ventaHistoriales = [];
    for (var map in maps) {
      final venta = await ventaRepository.getById(map['ventaId'] as int);
      ventaHistoriales.add(VentaHistoricoMapper.fromMap(map, venta));
    }
    return ventaHistoriales;
  }
}
