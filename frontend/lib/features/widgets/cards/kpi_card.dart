import 'package:flutter/material.dart';

class KpiCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const KpiCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(data['title'] ?? 'KPI', style: Theme.of(context).textTheme.titleMedium),
            Text(data['value'] ?? '0', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
