import 'package:flutter/material.dart';

import '../extensions/responsive_size.dart';

/// Represents the font size entity/model.
class FontSize {
  static double get caption => 10.0.sp;
  static double get overline => 11.0.sp;
  static double get paragraph => 12.0.sp;
  static double get details => 14.0.sp;
  static double get bodyText => 16.0.sp;
  static double get subTitle => 18.0.sp;
  static double get title => 24.0.sp;
  static double get mainTitle => 32.0.sp;
  static double get heroScore => 40.0.sp;
}

/// Represents the font weights entity/model.
class FontWeights {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

/// Represents letter spacing tokens
class AppLetterSpacing {
  static const double tight = -0.5;
  static const double normal = 0.0;
  static const double wide = 0.5;
  static const double extraWide = 1.0;
}
