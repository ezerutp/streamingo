import 'package:streamingo/modules/venta/domain/venta.dart';
import 'package:streamingo/modules/venta/repo/venta_repo.dart';
import 'package:streamingo/modules/venta/service/venta_historial_service.dart';

class VentaService {
  final VentaRepository _ventaRepository = VentaRepository();
  final VentaHistorialService _ventaHistorialService = VentaHistorialService();

  Future<int> save(Venta venta) async {
    final int id = await _ventaRepository.save(venta);
    try {
      venta.setId = id;
    } catch (e) {
      // No manejar nada por el momento
    }
    await _ventaHistorialService.save(venta);
    return id;
  }

  Future<Venta?> getById(int id) async {
    return await _ventaRepository.getById(id);
  }

  Future<List<Venta>> getVentasCanceladas() async {
    return await _ventaRepository.getDeleted();
  }

  Future<List<Venta>> getVentasActivas() async {
    return await _ventaRepository.getVentasActivas();
  }

  Future<int> delete(Venta venta) async {
    return await _ventaRepository.delete(venta);
  }

  Future<int> cancelarVenta(Venta venta) async {
    return await _ventaRepository.cancel(venta);
  }
}
