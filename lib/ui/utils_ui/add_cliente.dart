import 'package:flutter/material.dart';
import 'package:streamingo/modules/clientes/domain/cliente.dart';
import 'package:streamingo/modules/clientes/services/cliente_service.dart';

class AddClienteForm extends StatefulWidget {
  final ClienteService clienteService;
  final VoidCallback? onClienteAdded;

  const AddClienteForm({
    super.key,
    required this.clienteService,
    this.onClienteAdded,
  });

  @override
  State<AddClienteForm> createState() => _AddClienteFormState();
}

class _AddClienteFormState extends State<AddClienteForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _telefonoController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveCliente() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final newCliente = Cliente(
        id: null,
        name: _nameController.text.trim(),
        telefono:
            _telefonoController.text.trim().isEmpty
                ? null
                : _telefonoController.text.trim(),
        email:
            _emailController.text.trim().isEmpty
                ? null
                : _emailController.text.trim(),
        deleted: false,
      );

      await widget.clienteService.createCliente(newCliente);

      if (mounted) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cliente agregado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );

        // Limpiar formulario
        _nameController.clear();
        _telefonoController.clear();
        _emailController.clear();

        // Callback para actualizar la lista de clientes
        widget.onClienteAdded?.call();

        // Cerrar el formulario si está en un diálogo
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al agregar cliente: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nuevo cliente',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Campo de Nombre (obligatorio)
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre *',
                hintText: 'Nombre del cliente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Campo de Teléfono (opcional)
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Teléfono del cliente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Campo de Email (opcional)
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Email del cliente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value != null && value.trim().isNotEmpty) {
                  // Validación simple de email
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Ingrese un email válido';
                  }
                }
                return null;
              },
              onFieldSubmitted: (_) => _saveCliente(),
            ),
            const SizedBox(height: 24),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      _isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveCliente,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Función helper para mostrar el formulario en un diálogo
void showAddClienteDialog({
  required BuildContext context,
  required ClienteService clienteService,
  VoidCallback? onClienteAdded,
}) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: AddClienteForm(
              clienteService: clienteService,
              onClienteAdded: onClienteAdded,
            ),
          ),
        ),
  );
}
