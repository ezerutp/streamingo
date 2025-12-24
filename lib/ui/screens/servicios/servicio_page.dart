import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';

class ServicioPage extends StatefulWidget {
  const ServicioPage({super.key});

  @override
  State<ServicioPage> createState() => _ServicioPageState();
}

class _ServicioPageState extends State<ServicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servicio')),
      body: const Center(child: Text('Servicio Page')),
      endDrawer: const AppDrawer(),
    );
  }
}
