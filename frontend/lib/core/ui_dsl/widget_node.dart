import 'node.dart';

class WidgetNode extends UINode {
  final Map<String, dynamic> data;

  WidgetNode({
    required String type,
    required this.data,
  }) : super(type);

  factory WidgetNode.fromJson(Map<String, dynamic> json) {
    return WidgetNode(
      type: json['type'],
      data: json['data'] ?? {},
    );
  }
}
