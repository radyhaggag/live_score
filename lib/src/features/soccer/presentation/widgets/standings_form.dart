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
    2 => context.colorsExt.deepOrange, // Amber/Orange for Draw
    _ => context.colorsExt.grey.withOpacitySafe(0.2),
  };

  String? _letter(BuildContext context, int number) => switch (number) {
    0 => context.l10n.lostShort,
    1 => context.l10n.wonShort,
    2 => context.l10n.drawnShort,
    _ => null,
  };

  Widget? _text(BuildContext context, int number) {
    final letter = _letter(context, number);
    if (letter == null) return null;
    return Text(
      letter,
      style: TextStyle(
        color: context.colorsExt.white,
        fontSize: itemSize * 0.7,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _square({Widget? child, required Color color}) => Container(
    width: itemSize,
    height: itemSize,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.r), // Rounded square
    ),
    alignment: Alignment.center,
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
        (index) => _square(
          child: _text(context, padded[index]),
          color: _background(context, padded[index]),
        ),
      ),
    );
  }
}
