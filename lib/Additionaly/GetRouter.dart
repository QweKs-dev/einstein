import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetRouter {
  static Function(Widget widget) onLoadRoute;
  static Widget _lastWidget;

  static off(Widget w) {
    Get.off(w);
    _lastWidget = w;
    onLoadRoute?.call(w);
  }

  static to(Widget w) {
    Get.to(w);
    onLoadRoute?.call(w);
  }

  static back() {
    Get.back();
    if(_lastWidget!=null)onLoadRoute?.call(_lastWidget);
  }
}
