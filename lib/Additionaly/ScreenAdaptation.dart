import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ScreenAdaptation {
  static ScreenUtil utils;
  static ScreenUtil parentUtils;

  static setup(double width, double height) {
    utils = ScreenUtil(
        uiWidthPx: width, uiHeightPx: height, allowFontScaling: false);
  }

  static double dp(double val) {
    return utils.setSp(val);
  }

  static double sp(double val) {
    return utils.setSp(val);
  }

  static double height([double val]) {
    if (val == null) return utils.parentHeight;
    return utils.setHeight(val);
  }

  static double width([double val]) {
    if (val == null) return utils.parentWidth;
    return utils.setWidth(val);
  }
}

class ScreenUtil {
  static ScreenUtil _instance;
  static const int defaultWidth = 1080;
  static const int defaultHeight = 1920;

  num uiWidthPx;
  num uiHeightPx;

  bool allowFontScaling;

  double screenWidth;
  double screenHeight;

  ScreenUtil(
      {this.uiWidthPx = defaultWidth,
      this.uiHeightPx = defaultHeight,
      this.allowFontScaling = false});

  setByParent(BoxConstraints size) {
    this.screenWidth = size.maxWidth;
    this.screenHeight = size.maxHeight;
  }

  resetParent() {
    this.screenWidth = null;
    this.screenHeight = null;
  }

  double get parentWidth => screenWidth ?? Get.context.width;

  double get parentHeight => screenHeight ?? Get.context.height;

  double get textScaleFactor => Get.mediaQuery.textScaleFactor;

  double get pixelRatio => Get.mediaQuery.devicePixelRatio;

  double get screenWidthPx => parentWidth * pixelRatio;

  double get screenHeightPx => parentHeight * pixelRatio;

  double get statusBarHeight => Get.mediaQuery.padding.top;

  double get bottomBarHeight => Get.mediaQuery.padding.bottom;

  double get scaleWidth => parentWidth / (parentWidth > parentHeight ?uiHeightPx:uiWidthPx);

  double get scaleHeight => parentHeight / (parentWidth > parentHeight ?uiWidthPx:uiHeightPx);

  double get scaleText => parentWidth > parentHeight ? scaleHeight : scaleWidth;

  num setWidth(num width) => width * scaleWidth;

  num setHeight(num height) => height * scaleHeight;

  num setSp(num fontSize, {bool allowFontScalingSelf}) =>
      (fontSize * scaleText) /
      ((allowFontScalingSelf ?? allowFontScaling) ? textScaleFactor : 1);
}
