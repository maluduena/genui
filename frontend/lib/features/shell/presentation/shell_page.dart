import 'package:flutter/material.dart';
import 'left_menu.dart';
import 'chat_panel.dart';
import '../../dashboard/presentation/dashboard_host.dart';
import '../../dashboard/dashboard_controller.dart';

class ShellPage extends StatelessWidget {
  ShellPage({super.key});
  final dashboardController = DashboardController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          appBar: isMobile
              ? AppBar(
                  title: const Text('Tesorería'),
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                )
              : null,

          drawer: isMobile ? const LeftMenu() : null,

          body: Row(
            children: [
              if (!isMobile) const LeftMenu(),
             Expanded(
      child: DashboardHost(
        controller: dashboardController,
      ),
    ),
    SizedBox(
      width: 320,
      child: ChatPanel(
        dashboardController: dashboardController,
      ),
    ),
            ],
          ),
        );
      },
    );
  }
}
