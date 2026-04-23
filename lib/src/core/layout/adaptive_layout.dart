import 'dart:math' as math;

import 'package:flutter/material.dart';

enum AppWindowSize { compact, medium, expanded }

extension AdaptiveLayoutX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  AppWindowSize get windowSize {
    if (screenWidth >= 1100) {
      return AppWindowSize.expanded;
    }
    if (screenWidth >= 700) {
      return AppWindowSize.medium;
    }
    return AppWindowSize.compact;
  }

  bool get isCompactWindow => windowSize == AppWindowSize.compact;

  bool get isExpandedWindow => windowSize == AppWindowSize.expanded;

  double get pageHorizontalPadding => switch (windowSize) {
    AppWindowSize.compact => 16,
    AppWindowSize.medium => 24,
    AppWindowSize.expanded => 32,
  };

  double get maxContentWidth => switch (windowSize) {
    AppWindowSize.compact => 680,
    AppWindowSize.medium => 920,
    AppWindowSize.expanded => 1200,
  };
}

class AdaptiveContentArea extends StatelessWidget {
  const AdaptiveContentArea({
    super.key,
    required this.child,
    this.topPadding = 12,
    this.bottomPadding = 16,
  });

  final Widget child;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = context.pageHorizontalPadding;
        final contentWidth = math.min(
          context.maxContentWidth,
          constraints.maxWidth,
        );

        return Center(
          child: SizedBox(
            width: contentWidth,
            height: constraints.maxHeight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                bottomPadding,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
