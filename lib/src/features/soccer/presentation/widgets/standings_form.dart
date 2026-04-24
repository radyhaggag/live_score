import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import 'package:live_score/src/core/extensions/context_ext.dart';

/// Renders the last 5 match results as colored dot indicators.
class StandingsForm extends StatelessWidget {
  final List<int> form;
  final double itemSize;
  final double spacing;

  const StandingsForm({
    super.key,
    required this.form,
    this.itemSize = 15,
    this.spacing = 5,
  });

  Color _background(BuildContext context, int number) => switch (number) {
    1 => context.colorsExt.green,
    0 => context.colorsExt.red,
    2 => context.colorsExt.grey,
    _ => context.colorsExt.grey.withOpacitySafe(0.2),
  };

  Icon? _icon(BuildContext context, int number) => switch (number) {
    0 => _smallIcon(context, Icons.close),
    1 => _smallIcon(context, Icons.check),
    2 => _smallIcon(context, Icons.remove),
    _ => null,
  };

  Icon _smallIcon(BuildContext context, IconData icon) =>
      Icon(icon, color: context.colorsExt.white, size: itemSize * 0.8);

  Widget _circle({Widget? child, required Color color}) => Container(
    width: itemSize,
    height: itemSize,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    // Show last 5 results; pad with -1 (empty) if fewer than 5 available.
    final padded = [
      ...form.reversed.take(5),
      ...List.filled((5 - form.length).clamp(0, 5), -1),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: spacing,
      children: List.generate(
        5,
        (index) => _circle(
          child: _icon(context, padded[index]),
          color: _background(context, padded[index]),
        ),
      ),
    );
  }
}
