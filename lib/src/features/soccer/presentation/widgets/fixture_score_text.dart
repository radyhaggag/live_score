import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';

/// Styled score text used in fixture cards.
class FixtureScoreText extends StatelessWidget {
  final String value;
  final Color? color;

  const FixtureScoreText({super.key, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: color ?? context.colors.onSurface,
        fontWeight: FontWeight.w800,
      ),
      textAlign: TextAlign.center,
    );
  }
}
