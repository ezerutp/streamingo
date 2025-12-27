import 'package:streamingo/modules/venta/domain/venta.dart';

class VentaMapper {
  // Convertir un mapa a un objeto Venta
  static Venta fromMap(
    Map<String, dynamic> map,
    dynamic cliente,
    dynamic tipoServicio,
  ) {
    return Venta(
      id: map['id'],
      cliente: cliente,
      tipoServicio: tipoServicio,
      fechaInicio: DateTime.parse(map['fechaInicio']),
      fechaFin: DateTime.parse(map['fechaFin']),
      monto: map['monto'],
      cancelado: map['cancelado'] == 1 ? true : false,
      deleted: map['deleted'] == 1 ? true : false,
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
      'cancelado': venta.cancelado,
      'deleted': venta.deleted,
    };
  }
}
