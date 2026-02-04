import 'package:flutter/material.dart';
import '../../domain/entities/ui_node.dart';
import '../dashboard_controller.dart';
import 'ui_renderer.dart';

class DashboardHost extends StatelessWidget {
  final DashboardController controller;

  const DashboardHost({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final layout = controller.layout;
        
        if (layout == null) {
          return const Center(
            child: Text(
              'Esperando instrucciones...',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: UiRenderer.render(layout),
        );
      },
    );
  }
}
