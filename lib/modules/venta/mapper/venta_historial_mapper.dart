import 'package:streamingo/modules/venta/domain/venta_historial.dart';

class VentaHistoricoMapper {
  // Convertir un mapa a un objeto VentaHistorico
  static VentaHistorico fromMap(Map<String, dynamic> map, dynamic venta) {
    return VentaHistorico(
      id: map['id'] as int,
      venta: venta,
      fechaPago: DateTime.parse(map['fechaPago'] as String),
      fechaInicio: DateTime.parse(map['fechaInicio'] as String),
      fechaFin: DateTime.parse(map['fechaFin'] as String),
      montoPagado: map['montoPagado'] as double,
    );
  }

  // Convertir un objeto VentaHistorico a un mapa
  static Map<String, dynamic> toMap(VentaHistorico ventaHistorico) {
    return {
      'id': ventaHistorico.id,
      'ventaId': ventaHistorico.venta.id,
      'fechaPago': ventaHistorico.fechaPago.toIso8601String(),
      'fechaInicio': ventaHistorico.fechaInicio.toIso8601String(),
      'fechaFin': ventaHistorico.fechaFin.toIso8601String(),
      'montoPagado': ventaHistorico.montoPagado,
    };
  }
}
