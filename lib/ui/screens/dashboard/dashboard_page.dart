import 'package:flutter/material.dart';
import 'package:streamingo/ui/components/app_drawer.dart';
import 'package:streamingo/ui/components/tail_card.dart';
import 'package:streamingo/ui/components/card_top.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TailwindDashboardCard(
                  title: "title",
                  subtitle: "subtitle",
                  value: index * 10,
                  icon: Icons.star,
                  color: Colors.blue,
                ),
              );
            }),
          ),
        ),
      ),

      endDrawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}
