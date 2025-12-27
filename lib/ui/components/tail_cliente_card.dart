import 'package:flutter/material.dart';
import 'package:streamingo/modules/clientes/domain/cliente.dart';

class TailwindClienteCard extends StatelessWidget {
  final Cliente cliente;

  const TailwindClienteCard({super.key, required this.cliente});

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
                SizedBox(width: 8),
                /* Text(
                  cliente.telefono ?? "",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ), */
              ],
            ),

            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Theme.of(
                    context,
                  ).primaryColor.withValues(alpha: 0.15),
                  child: Icon(
                    Icons.phone,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
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
                SizedBox(width: 8),
                CircleAvatar(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
