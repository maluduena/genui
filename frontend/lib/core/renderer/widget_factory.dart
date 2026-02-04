import 'package:flutter/material.dart';
import '../ui_dsl/widget_node.dart';
import '../../features/widgets/gantt/gantt_widget.dart';
import '../../features/widgets/charts/line_chart.dart';
import '../../features/widgets/cards/kpi_card.dart';

class WidgetFactory {
  static Widget build(WidgetNode node) {
    switch (node.type) {
      case 'gantt':
        return GanttWidget(node.data);
      case 'lineChart':
        return LineChartWidget(node.data);
      case 'kpi':
        return KpiCard(data: node.data);
      default:
        return Text('Widget desconocido: ${node.type}');
    }
  }
}
