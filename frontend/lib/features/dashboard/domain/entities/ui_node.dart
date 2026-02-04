class UiNode {
  final String? type;        // column, row, grid
  final String? widget;      // card, gantt, etc
  final Map<String, dynamic>? data;
  final List<UiNode>? children;

  UiNode({
    this.type,
    this.widget,
    this.data,
    this.children,
  });

  factory UiNode.fromJson(Map<String, dynamic> json) {
    return UiNode(
      type: json['type'],
      widget: json['widget'],
      data: json['data'],
      children: json['children'] != null
          ? (json['children'] as List)
              .map((e) => UiNode.fromJson(e))
              .toList()
          : null,
    );
  }
}
