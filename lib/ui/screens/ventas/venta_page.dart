import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({super.key});

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: const Center(
        child: Text('Página de Ventas', style: TextStyle(fontSize: 24)),
      ),
      endDrawer: const AppDrawer(),
    );
  }
}
