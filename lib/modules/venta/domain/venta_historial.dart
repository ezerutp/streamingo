import 'package:streamingo/modules/venta/domain/venta.dart';

class VentaHistorico {
  int id;
  Venta venta;
  DateTime fechaPago;
  DateTime fechaInicio;
  DateTime fechaFin;
  double montoPagado;

  VentaHistorico({
    required this.id,
    required this.venta,
    required this.fechaPago,
    required this.fechaInicio,
    required this.fechaFin,
    required this.montoPagado,
  });

  int get getId => id;
  int get getVentaId => venta.id;
  DateTime get getFechaPago => fechaPago;
  DateTime get getFechaInicio => fechaInicio;
  DateTime get getFechaFin => fechaFin;
  double get getMontoPagado => montoPagado;

  set setId(int value) => id = value;
  set setVentaId(int value) => venta.id = value;
  set setFechaPago(DateTime value) => fechaPago = value;
  set setFechaInicio(DateTime value) => fechaInicio = value;
  set setFechaFin(DateTime value) => fechaFin = value;
  set setMontoPagado(double value) => montoPagado = value;
}
