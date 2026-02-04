import 'package:flutter/material.dart';
import '../../domain/entities/ui_node.dart';

class UiRenderer {
  static Widget render(UiNode node) {
    // Layouts
    if (node.type != null) {
      switch (node.type) {
        case 'column':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: node.children?.map(render).toList() ?? [],
          );
        case 'row':
          return Row(
            children: node.children?.map(render).toList() ?? [],
          );
      }
    }

    // Widgets
    if (node.widget != null) {
      switch (node.widget) {
        case 'card':
          return _card(node.data);
      }
    }

    return const SizedBox.shrink();
  }

  static Widget _card(Map<String, dynamic>? data) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data?['title'] ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(data?['subtitle'] ?? ''),
          ],
        ),
      ),
    );
  }
}
