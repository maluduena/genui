import 'package:flutter/material.dart';
import '../ui_dsl/node.dart';
import '../ui_dsl/layout_node.dart';
import '../ui_dsl/widget_node.dart';
import 'layout_renderer.dart';
import 'widget_factory.dart';

class UIRenderer extends StatelessWidget {
  final UINode node;

  const UIRenderer(this.node, {super.key});

  @override
  Widget build(BuildContext context) {
    if (node is LayoutNode) {
      return LayoutRenderer(node as LayoutNode);
    }
    if (node is WidgetNode) {
      return WidgetFactory.build(node as WidgetNode);
    }
    return const SizedBox.shrink();
  }
}
