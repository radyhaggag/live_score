import 'package:flutter/material.dart';

import '../extensions/context_ext.dart';

/// Represents the app loading indicator entity/model.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.isLinear = false, this.color});

  final bool isLinear;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? context.colors.primary;

    if (isLinear) {
      return LinearProgressIndicator(color: indicatorColor);
    }

    return Center(child: CircularProgressIndicator(color: indicatorColor));
  }
}
