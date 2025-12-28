import 'package:flutter/material.dart';
import 'package:streamingo/modules/servicios/domain/servicio.dart';
import 'package:streamingo/modules/servicios/repo/servicio_repo.dart';
import 'package:streamingo/modules/servicios/services/servicio_service.dart';
import 'package:streamingo/ui/components/app_drawer.dart';
import 'package:streamingo/ui/components/tail_card_servicios.dart';
import 'package:streamingo/ui/utils_ui/add_services.dart';

class ServicioPage extends StatefulWidget {
  const ServicioPage({super.key});

  @override
  State<ServicioPage> createState() => _ServicioPageState();
}

class _ServicioPageState extends State<ServicioPage> {
  final ServicioService _servicioService = ServicioService(
    servicioRepository: ServicioRepository(),
  );

  List<Servicio> _servicios = [];
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadServicios();
  }

  Future<void> _loadServicios() async {
    setState(() => _isLoading = true);
    try {
      final servicios = await _servicioService.fetchServicios();
      setState(() {
        _servicios = servicios;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar servicios: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteServicio(Servicio servicio) async {
    setState(() => _isLoading = true);
    try {
      await _servicioService.removeServicio(servicio);
      _loadServicios();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar servicio: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredServicios =
        _servicios
            .where(
              (s) =>
                  s.nombre.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Servicios')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: TextStyle(color: Theme.of(context).primaryColor),
              decoration: InputDecoration(
                labelText: 'Buscar servicio...',
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Theme.of(context).primaryColor,
                filled: true,
                fillColor: Theme.of(context).cardColor,
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (filteredServicios.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Text(
                                    'No se encontraron servicios',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            else
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final double cardWidth =
                                      (constraints.maxWidth - 16) / 2;
                                  return Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: List.generate(
                                      filteredServicios.length,
                                      (index) {
                                        return SizedBox(
                                          width: cardWidth,
                                          child: TailwindCardServices(
                                            value:
                                                filteredServicios[index].nombre,
                                            onDelete:
                                                () => _deleteServicio(
                                                  filteredServicios[index],
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
            ),
          ],
        ),
      ),
      endDrawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddServicioDialog(
            context: context,
            servicioService: _servicioService,
            onServicioAdded: _loadServicios,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
