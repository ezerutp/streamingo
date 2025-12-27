import 'package:flutter/material.dart';

class TailwindDashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final IconData? icon;
  final ThemeData? theme;

  const TailwindDashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.icon,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final icon = this.icon ?? Icons.star;
    final theme = this.theme ?? Theme.of(context);
    final background = theme.cardColor;
    final shadowColor = theme.primaryColor.withValues(alpha: 0.1);
    final subtitleColor = theme.primaryColor.withValues(alpha: 0.6);

    return Container(
      width: 170,
      height: 200,
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
                    value,
                    style: TextStyle(
                      fontSize: 26,
                      color: theme.primaryColor,
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
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
