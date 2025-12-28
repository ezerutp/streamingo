import 'package:flutter/material.dart';
import 'package:streamingo/modules/servicios/domain/servicio.dart';
import 'package:streamingo/modules/servicios/services/servicio_service.dart';

class ServiciosForm extends StatefulWidget {
  final ServicioService servicioService;
  final VoidCallback? onServicioSaved;
  final Servicio? servicio;

  const ServiciosForm({
    super.key,
    required this.servicioService,
    this.onServicioSaved,
    this.servicio,
  });

  @override
  State<ServiciosForm> createState() => _ServiciosFormState();
}

class _ServiciosFormState extends State<ServiciosForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();

  bool _isLoading = false;
  bool get _isEditMode => widget.servicio != null;

  @override
  void initState() {
    super.initState();
    if (widget.servicio != null) {
      _nombreController.text = widget.servicio!.nombre;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _saveServicio() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final servicioData = Servicio(
        id: _isEditMode ? widget.servicio!.id : null,
        nombre: _nombreController.text.trim(),
        deleted: _isEditMode ? widget.servicio!.deleted : false,
      );

      if (_isEditMode) {
        await widget.servicioService.modifyServicio(servicioData);
      } else {
        await widget.servicioService.createServicio(servicioData);
      }

      if (mounted) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? 'Servicio actualizado exitosamente'
                  : 'Servicio agregado exitosamente',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Limpiar formulario solo si es modo agregar
        if (!_isEditMode) {
          _nombreController.clear();
        }

        // Callback para actualizar la lista de servicios
        widget.onServicioSaved?.call();

        // Cerrar el formulario si está en un diálogo
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode
                  ? 'Error al actualizar servicio: $e'
                  : 'Error al agregar servicio: $e',
            ),
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
              _isEditMode ? 'Editar servicio' : 'Nuevo servicio',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Campo de Nombre (obligatorio)
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre *',
                hintText: 'Nombre del servicio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.play_circle_fill),
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

            // Botón de Guardar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveServicio,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
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
                          : Text(_isEditMode ? 'Actualizar' : 'Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showAddServicioDialog({
  required BuildContext context,
  required ServicioService servicioService,
  VoidCallback? onServicioAdded,
}) {
  showServicioFormDialog(
    context: context,
    servicioService: servicioService,
    onServicioSaved: onServicioAdded,
  );
}

void showEditServicioDialog({
  required BuildContext context,
  required ServicioService servicioService,
  required Servicio servicio,
  VoidCallback? onServicioUpdated,
}) {
  showServicioFormDialog(
    context: context,
    servicioService: servicioService,
    servicio: servicio,
    onServicioSaved: onServicioUpdated,
  );
}

void showServicioFormDialog({
  required BuildContext context,
  required ServicioService servicioService,
  Servicio? servicio,
  VoidCallback? onServicioSaved,
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
            child: ServiciosForm(
              servicioService: servicioService,
              servicio: servicio,
              onServicioSaved: onServicioSaved,
            ),
          ),
        ),
  );
}
