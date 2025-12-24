import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';

class VentaHistoricoPage extends StatefulWidget {
  const VentaHistoricoPage({super.key});

  @override
  State<VentaHistoricoPage> createState() => _VentaHistoricoPageState();
}

class _VentaHistoricoPageState extends State<VentaHistoricoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Ventas')),
      body: const Center(
        child: Text(
          'Página de Histórico de Ventas',
          style: TextStyle(fontSize: 24),
        ),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
