import 'node.dart';
import 'layout_node.dart';
import 'widget_node.dart';

UINode parseNode(Map<String, dynamic> json) {
  if (json.containsKey('children')) {
    return LayoutNode.fromJson(json);
  }
  return WidgetNode.fromJson(json);
}
