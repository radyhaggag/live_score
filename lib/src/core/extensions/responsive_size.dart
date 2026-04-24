import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive size extensions that delegate to [ScreenUtil].
///
/// Since [flutter_screenutil] ships its own extension on `num` with the same
/// member names (`.w`, `.h`, `.sp`, `.r`), we delegate to those via an
/// explicit extension override to avoid ambiguous-member errors. This file is
/// the **only** import point for responsive scaling in the project — UI code
/// must never import `flutter_screenutil` directly.
///
/// Usage:
/// ```dart
/// SizedBox(width: 16.w, height: 24.h)
/// Text('...', style: TextStyle(fontSize: 14.sp))
/// BorderRadius.circular(12.r)
/// ```
extension ResponsiveSizeExt on num {
  /// Scales width relative to the design width (375).
  double get w => ScreenUtil().setWidth(toDouble());

  /// Scales height relative to the design height (812).
  double get h => ScreenUtil().setHeight(toDouble());

  /// Scales font size, adapting to text scale factor.
  double get sp => ScreenUtil().setSp(toDouble());

  /// Scales a radius value proportionally (uses width scale).
  double get r => ScreenUtil().radius(toDouble());
}
