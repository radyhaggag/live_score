import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';

/// Styled score text used in fixture cards.
class FixtureScoreText extends StatelessWidget {
  final String value;
  const FixtureScoreText({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: context.colorsExt.deepOrange,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
