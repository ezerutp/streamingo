import 'package:flutter/material.dart';

class TailwindDashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int value;
  final IconData icon;
  final Color color;

  const TailwindDashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Colores dinámicos según tema (Tailwind style)
    final background =
        theme.brightness == Brightness.light ? Colors.white : Colors.grey[900];

    final shadowColor =
        theme.brightness == Brightness.light
            ? Colors.black.withOpacity(0.05)
            : Colors.black.withOpacity(0.3);

    final subtitleColor =
        theme.brightness == Brightness.light
            ? Colors.grey[600]
            : Colors.grey[400];

    return Container(
      width: 170,
      height: 200,
      constraints: const BoxConstraints(
        minHeight: 160, // evita overflow, permite crecer
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4), // estilo shadow-md
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icono estilo Tailwind (circulito suave)
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: color.withValues(
                      alpha: 0.15,
                    ), // bg-blue-100
                    child: Icon(icon, color: color, size: 24),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 26,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                ],
              ),
            ),
          ),

          // Footer tipo "border-t" de Tailwind
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: theme.dividerColor.withOpacity(0.3)),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
