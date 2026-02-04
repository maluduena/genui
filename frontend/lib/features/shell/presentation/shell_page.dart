import 'package:flutter/material.dart';
import 'package:frontend/core/renderer/ui_renderer.dart';
import '../../core/state/ui_state.dart';
import 'left_menu.dart';
import 'chat_panel.dart';

class ShellPage extends StatelessWidget {
  final UIState uiState;

  const ShellPage({required this.uiState, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const LeftMenu(),
          // Main Content Area that listens to state changes
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(24),
              child: ListenableBuilder(
                listenable: uiState,
                builder: (context, child) {
                  return UIRenderer(uiState.rootNode);
                },
              ),
            ),
          ),
          ChatPanel(uiState: uiState),
        ],
      ),
    );
  }
}
