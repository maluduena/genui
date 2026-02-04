import 'package:flutter/material.dart';
import '../ui_dsl/layout_node.dart';
import 'ui_renderer.dart';

class LayoutRenderer extends StatelessWidget {
  final LayoutNode node;

  const LayoutRenderer(this.node, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (node.type) {
      case 'vertical':
        return Column(
          children: node.children.map((c) => UIRenderer(c)).toList(),
        );
      case 'horizontal':
        return Row(
          children: node.children.map((c) => Expanded(child: UIRenderer(c))).toList(),
        );
      case 'grid':
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: node.props['columns'] ?? 2,
          children: node.children.map((c) => UIRenderer(c)).toList(),
        );
      case 'carousel':
        return SizedBox(
          height: (node.props['height'] as num?)?.toDouble() ?? 200,
          child: PageView(
            children: node.children.map((c) => UIRenderer(c)).toList(),
          ),
        );
      default:
        return Column(
          children: node.children.map((c) => UIRenderer(c)).toList(),
        );
    }
  }
}
