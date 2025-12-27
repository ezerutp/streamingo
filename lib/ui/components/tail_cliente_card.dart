import 'package:flutter/material.dart';
import 'package:streamingo/modules/clientes/domain/cliente.dart';

class TailwindClienteCard extends StatelessWidget {
  final Cliente cliente;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onRestore;
  final bool isDeleted;

  const TailwindClienteCard({
    super.key,
    required this.cliente,
    this.onDelete,
    this.onEdit,
    this.onRestore,
    this.isDeleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.15),
                  child: Text(
                    cliente.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  cliente.name.toUpperCase(),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            // Mostrar restaurar si está eliminado
            isDeleted
                ? InkWell(
                  onTap:
                      onRestore != null
                          ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Confirmar restauración'),
                                  content: const Text(
                                    '¿Estás seguro de que deseas restaurar este cliente?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                        onRestore!();
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.green,
                                      ),
                                      child: const Text('Restaurar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          : null,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.15),
                    child: Icon(
                      Icons.restore,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                  ),
                )
                : Row(
                  children: [
                    InkWell(
                      onTap:
                          onDelete != null
                              ? () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Confirmar eliminación',
                                      ),
                                      content: const Text(
                                        '¿Estás seguro de que deseas eliminar este cliente?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(dialogContext).pop();
                                            onDelete!();
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                              : null,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.15),
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap:
                          onEdit != null
                              ? () {
                                onEdit!();
                              }
                              : null,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.15),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
