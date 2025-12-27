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

  List<Cliente> clientesActivos = [];
  List<Cliente> clientesEliminados = [];
  bool _isLoading = true;

  // Buscador por pestaña
  String _searchActivos = '';
  String _searchEliminados = '';

  @override
  void initState() {
    super.initState();
    _loadClientes();
  }

  Future<void> _loadClientes() async {
    setState(() => _isLoading = true);
    try {
      // Cargar clientes activos y eliminados en paralelo
      final results = await Future.wait([
        _clienteService.fetchClientes(),
        _clienteService.fetchDeletedClientes(),
      ]);

      setState(() {
        clientesActivos = results[0];
        clientesEliminados = results[1];

        // Ordenar ambas listas por nombre
        //clientesActivos.sort((a, b) => a.name.compareTo(b.name));
        //clientesEliminados.sort((a, b) => a.name.compareTo(b.name));

        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
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

  List<Cliente> _filtrar(List<Cliente> list, String query) {
    if (query.trim().isEmpty) return list;
    final q = query.toLowerCase();
    return list.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  Future<void> _deleteCliente(Cliente cliente) async {
    try {
      await _clienteService.removeCliente(cliente);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente "${cliente.name}" eliminado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
      await _loadClientes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar cliente: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _editCliente(Cliente cliente) {
    showEditClienteDialog(
      context: context,
      clienteService: _clienteService,
      cliente: cliente,
      onClienteUpdated: _loadClientes,
    );
  }

  Future<void> _restoreCliente(Cliente cliente) async {
    try {
      await _clienteService.restoreCliente(cliente);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente "${cliente.name}" restaurado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
      await _loadClientes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al restaurar cliente: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final activosFiltrados = _filtrar(clientesActivos, _searchActivos);
    final eliminadosFiltrados = _filtrar(clientesEliminados, _searchEliminados);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Clientes'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Activos'), Tab(text: 'Eliminados')],
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
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                  children: [
                    _ClientesTab(
                      hintBuscar: 'Buscar cliente activo...',
                      searchValue: _searchActivos,
                      onSearchChanged:
                          (v) => setState(() => _searchActivos = v),
                      clientes: activosFiltrados,
                      emptyText: 'No hay clientes activos',
                      onDelete: _deleteCliente,
                      onEdit: _editCliente,
                      isDeleted: false,
                    ),
                    _ClientesTab(
                      hintBuscar: 'Buscar cliente eliminado...',
                      searchValue: _searchEliminados,
                      onSearchChanged:
                          (v) => setState(() => _searchEliminados = v),
                      clientes: eliminadosFiltrados,
                      emptyText: 'No hay clientes eliminados',
                      onRestore: _restoreCliente,
                      isDeleted: true,
                    ),
                  ],
                ),
      ),
    );
  }
}

class _ClientesTab extends StatelessWidget {
  const _ClientesTab({
    required this.hintBuscar,
    required this.searchValue,
    required this.onSearchChanged,
    required this.clientes,
    required this.emptyText,
    this.onDelete,
    this.onEdit,
    this.onRestore,
    this.isDeleted = false,
  });

  final String hintBuscar;
  final String searchValue;
  final ValueChanged<String> onSearchChanged;
  final List<Cliente> clientes;
  final String emptyText;
  final Future<void> Function(Cliente)? onDelete;
  final void Function(Cliente)? onEdit;
  final Future<void> Function(Cliente)? onRestore;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: onSearchChanged,
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              labelText: hintBuscar,
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
          const SizedBox(height: 28),
          Expanded(
            child:
                clientes.isEmpty
                    ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          emptyText,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: clientes.length,
                      itemBuilder: (context, index) {
                        final cliente = clientes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TailwindClienteCard(
                            cliente: cliente,
                            isDeleted: isDeleted,
                            onDelete:
                                onDelete != null
                                    ? () => onDelete!(cliente)
                                    : null,
                            onEdit:
                                onEdit != null ? () => onEdit!(cliente) : null,
                            onRestore:
                                onRestore != null
                                    ? () => onRestore!(cliente)
                                    : null,
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
