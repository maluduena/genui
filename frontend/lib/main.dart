import 'package:flutter/material.dart';
import 'features/shell/presentation/shell_page.dart';
import 'core/state/ui_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize State
    final uiState = UIState.initial();

    return MaterialApp(
      title: 'GenUI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: ShellPage(uiState: uiState),
    );
  }
}
