import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveDouble on double {
  double get width => w;
  double get height => h;
  double get radius => r;
}

extension ResponsiveInt on int {
  double get width => w.toDouble();
  double get height => h.toDouble();
  double get radius => r.toDouble();
}
