import 'node.dart';
import 'ui_schema.dart';

class LayoutNode extends UINode {
  final List<UINode> children;
  final Map<String, dynamic> props;

  LayoutNode({
    required String type,
    this.children = const [],
    this.props = const {},
  }) : super(type);

  factory LayoutNode.fromJson(Map<String, dynamic> json) {
    return LayoutNode(
      type: json['type'],
      props: json,
      children: (json['children'] as List? ?? [])
          .map((e) => parseNode(e))
          .toList(),
    );
  }
}
