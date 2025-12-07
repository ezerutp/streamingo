import 'package:streamingo/modules/venta/domain/venta.dart';
import 'package:streamingo/modules/venta/domain/venta_historial.dart';
import 'package:streamingo/modules/venta/repo/venta_historial_repo.dart';

class VentaHistorialService {
  final VentaHistorialRepository _ventaHistorialRepository =
      VentaHistorialRepository();

  Future<int> save(Venta venta) async {
    VentaHistorico ventaHistorico = VentaHistorico(
      id: null,
      venta: venta,
      fechaPago: DateTime.now(),
      fechaInicio: venta.fechaInicio,
      fechaFin: venta.fechaFin,
      montoPagado: venta.monto,
    );
    return await _ventaHistorialRepository.save(ventaHistorico);
  }

  Future<VentaHistorico?> getById(int id) async {
    return await _ventaHistorialRepository.getById(id);
  }

  Future<List<VentaHistorico>> getAll() async {
    return await _ventaHistorialRepository.getAll();
  }

  Future<List<VentaHistorico>> getByMonth(DateTime dateTime) async {
    return await _ventaHistorialRepository.getByMonth(dateTime);
  }
}
