import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/clientes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/servicios');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Tipos de Servicios'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/servicios_tipos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Ventas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ventas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histórico de Ventas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ventas_historico');
            },
          ),
        ],
      ),
    );
  }
}
