import 'package:flutter/material.dart';
import '../screens/home/home_page.dart';
import '../screens/dashboard/dashboard_page.dart';
import '../screens/clientes/clientes_page.dart';
import '../screens/servicios/servicio_page.dart';
import '../screens/servicios/servicio_tipo_page.dart';
import '../screens/ventas/venta_page.dart';
import '../screens/ventas/venta_historico_page.dart';

class AppRouter {
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomePage(),
    '/': (context) => const DashboardPage(),
    '/clientes': (context) => const ClienteHome(),
    '/servicios': (context) => const ServicioPage(),
    '/servicios_tipos': (context) => const ServicioTipo(),
    '/ventas': (context) => const VentaPage(),
    '/ventas_historico': (context) => const VentaHistoricoPage(),
  };
}
