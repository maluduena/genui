import 'package:flutter/foundation.dart';
import 'domain/entities/ui_node.dart';

class DashboardController extends ChangeNotifier {
  UiNode? _layout;

  UiNode? get layout => _layout;

  void setLayout(UiNode layout) {
    _layout = layout;
    notifyListeners();
  }
}
