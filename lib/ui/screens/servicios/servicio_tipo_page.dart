import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';

class ServicioTipo extends StatefulWidget {
  const ServicioTipo({super.key});

  @override
  State<ServicioTipo> createState() => _ServicioTipoState();
}

class _ServicioTipoState extends State<ServicioTipo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servicio Tipo')),
      body: const Center(child: Text('Servicio Tipo Page')),
      endDrawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, "/clientes")},
        child: const Icon(Icons.add),
      ),
    );
  }
}
