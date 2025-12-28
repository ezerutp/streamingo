import 'package:flutter/material.dart';

class TailwindCardServices extends StatelessWidget {
  final String value;
  final IconData? icon;
  final ThemeData? theme;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TailwindCardServices({
    super.key,
    required this.value,
    this.icon,
    this.theme,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final icon = this.icon ?? Icons.play_circle;
    final theme = this.theme ?? Theme.of(context);
    final background = theme.cardColor;
    final shadowColor = theme.primaryColor.withValues(alpha: 0.1);

    return Container(
      width: 170,
      height: 160,
      constraints: const BoxConstraints(minHeight: 160),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.primaryColor.withValues(alpha: 0.15),
                    child: Icon(icon, color: theme.primaryColor, size: 24),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    value.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed:
                      onDelete != null
                          ? () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: const Text('Confirmar eliminación'),
                                  content: const Text(
                                    '¿Estás seguro de que deseas eliminar este servicio?',
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
                  child: Text(
                    'Eliminar',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: onEdit,
                  child: Text(
                    'Editar',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
