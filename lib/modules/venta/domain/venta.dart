import 'package:streamingo/modules/clientes/domain/cliente.dart';
import 'package:streamingo/modules/servicios/domain/tipo_servicio.dart';

class Venta {
  int id;
  Cliente cliente;
  TipoServicio tipoServicio;
  DateTime fechaInicio;
  DateTime fechaFin;
  double monto;
  bool cancelado = false;
  bool deleted;

  Venta({
    required this.id,
    required this.cliente,
    required this.tipoServicio,
    required this.fechaInicio,
    required this.fechaFin,
    required this.monto,
    this.cancelado = false,
    this.deleted = false,
  });

  int get getId => id;
  Cliente get getCliente => cliente;
  TipoServicio get getTipoServicio => tipoServicio;
  DateTime get getFechaInicio => fechaInicio;
  DateTime get getFechaFin => fechaFin;
  double get getMonto => monto;
  bool get isCancelado => cancelado;
  bool get getDeleted => deleted;

  set setId(int value) => id = value;
  set setCliente(Cliente value) => cliente = value;
  set setTipoServicio(TipoServicio value) => tipoServicio = value;
  set setFechaInicio(DateTime value) => fechaInicio = value;
  set setFechaFin(DateTime value) => fechaFin = value;
  set setMonto(double value) => monto = value;
  set setCancelado(bool value) => cancelado = value;
  set setDeleted(bool value) => deleted = value;
}
