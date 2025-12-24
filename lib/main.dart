import 'package:flutter/material.dart';
import 'ui/routes/app_router.dart';
import 'ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreaminGo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark, // tu tema separado
      initialRoute: AppRouter.initialRoute,
      routes: AppRouter.routes, // navegación centralizada
    );
  }
}
