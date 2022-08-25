import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}
