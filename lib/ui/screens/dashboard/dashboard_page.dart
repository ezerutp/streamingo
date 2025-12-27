import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';
import 'package:streamingo/ui/components/tail_card.dart';
import 'package:streamingo/modules/clientes/services/cliente_service.dart';
import 'package:streamingo/modules/clientes/repo/cliente_repo.dart';
import 'package:streamingo/modules/clientes/domain/cliente.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ClienteService _clienteService = ClienteService(
    clientRepo: ClienteRepository(),
  );

  // Count info
  int totalClientes = 0;
  int totalServicios = 0;
  int totalTipoServicios = 0;

  // Listas temporales
  List<String> lista = ["Usuarios", "Clientes", "Servicios", "Tipo servicios"];
  List<String> valores = ["0", "0", "0", "0"];
  List<String> subtitulo = ["Activos", "Activos", "Registrados", "Registrados"];
  List<IconData> iconos = [
    Icons.person,
    Icons.people,
    Icons.play_circle,
    Icons.event,
  ];

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    List<Cliente> clientes = await _clienteService.fetchClientes();
    setState(() {
      totalClientes = clientes.length;
      valores[0] = totalClientes.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = (constraints.maxWidth - 16) / 2;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: cardWidth,
                        child: TailwindDashboardCard(
                          title: lista[index],
                          subtitle: subtitulo[index],
                          value: valores[index],
                          icon: iconos[index],
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                "Últimas Ventas",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(1, (index) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "No hay ventas registradas hoy",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      endDrawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, "/clientes")},
        child: const Icon(Icons.add),
      ),
    );
  }
}
