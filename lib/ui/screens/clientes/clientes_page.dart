import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';
import 'package:streamingo/modules/clientes/domain/cliente.dart';
import 'package:streamingo/ui/components/tail_cliente_card.dart';
import 'package:streamingo/ui/utils_ui/add_cliente.dart';
import 'package:streamingo/modules/clientes/services/cliente_service.dart';
import 'package:streamingo/modules/clientes/repo/cliente_repo.dart';

class ClienteHome extends StatefulWidget {
  const ClienteHome({super.key});

  @override
  State<ClienteHome> createState() => _ClienteHomeState();
}

class _ClienteHomeState extends State<ClienteHome> {
  final ClienteService _clienteService = ClienteService(
    clientRepo: ClienteRepository(),
  );
  List<Cliente> clientes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final fetchedClientes = await _clienteService.fetchClientes();

      setState(() {
        clientes = fetchedClientes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar clientes: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Buscar cliente...',
                  prefixIcon: Icon(Icons.search),
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
              const SizedBox(height: 36),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (clientes.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "No hay clientes registrados",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              else
                Column(
                  children: List.generate(clientes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: TailwindClienteCard(cliente: clientes[index]),
                      ),
                    );
                  }),
                ),
            ],
          ),
        ),
      ),
      endDrawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddClienteDialog(
            context: context,
            clienteService: _clienteService,
            onClienteAdded: _loadClientes,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
