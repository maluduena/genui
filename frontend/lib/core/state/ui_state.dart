import 'package:flutter/material.dart';
import '../ui_dsl/node.dart';
import '../ui_dsl/layout_node.dart';
import '../ui_dsl/widget_node.dart';

class UIState extends ChangeNotifier {
  UINode _rootNode;

  UIState(this._rootNode);

  UINode get rootNode => _rootNode;

  void updateUI(UINode newNode) {
    _rootNode = newNode;
    notifyListeners();
  }

  // Helper helper method to show initial state
  static UIState initial() {
    return UIState(
      LayoutNode(
        type: 'vertical',
        children: [
          LayoutNode(
            type: 'horizontal',
            children: [
              WidgetNode(type: 'kpi', data: {'title': 'Revenue', 'value': '\$10M'}),
              WidgetNode(type: 'kpi', data: {'title': 'Users', 'value': '1.2M'}),
              WidgetNode(type: 'kpi', data: {'title': 'Growth', 'value': '+15%'}),
            ],
          ),
          WidgetNode(type: 'lineChart', data: {'title': 'Monthly Sales'}),
        ],
      ),
    );
  }
}
