import 'package:flutter/material.dart';

import '../extensions/responsive_size.dart';

/// Represents the font size entity/model.
class FontSize {
  static double get paragraph => 12.0.sp;
  static double get details => 14.0.sp;
  static double get bodyText => 16.0.sp;
  static double get subTitle => 18.0.sp;
  static double get title => 24.0.sp;
  static double get mainTitle => 32.0.sp;
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
