import 'package:flutter/material.dart';

abstract class AppSizes {
  static const double kPaddingVerySmall = 4;
  static const double kPaddingSmall = 8;
  static const double kPaddingMedium = 16;
  static const double kPaddingLarge = 32;
  static const double kPaddingVeryLarge = 64;

  static const double kSizeVerySmall = 5;
  static const double kSizeSmall = 10;
  static const double kSizeMedium = 20;
  static const double kSizeLarge = 40;
  static const double kSizeVeryLarge = 80;

  static const num appLittleElevation = 2;
  static const double appMoreElevation = 4.0;

  static const double sizeLittleBorderRadius = 25;
  static const double sizeMoreBorderRadius = 50;
}
class App {
  late BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height - ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding = _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}



