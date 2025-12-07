import 'package:streamingo/modules/venta/domain/venta.dart';

class VentaMapper {
  // Convertir un mapa a un objeto Venta
  static Venta fromMap(
    Map<String, dynamic> map,
    dynamic cliente,
    dynamic tipoServicio,
  ) {
    return Venta(
      id: map['id'] as int,
      cliente: cliente,
      tipoServicio: tipoServicio,
      fechaInicio: DateTime.parse(map['fechaInicio'] as String),
      fechaFin: DateTime.parse(map['fechaFin'] as String),
      monto: map['monto'] as double,
      cancelado: (map['cancelado'] as int) == 1,
      deleted: (map['deleted'] as int) == 1,
    );
  }

  // Convertir un objeto Venta a un mapa
  static Map<String, dynamic> toMap(Venta venta) {
    return {
      'id': venta.id,
      'clienteId': venta.cliente.id,
      'tipoServicioId': venta.tipoServicio.id,
      'fechaInicio': venta.fechaInicio.toIso8601String(),
      'fechaFin': venta.fechaFin.toIso8601String(),
      'monto': venta.monto,
      'cancelado': venta.cancelado ? 1 : 0,
      'deleted': venta.deleted ? 1 : 0,
    };
  }
}
