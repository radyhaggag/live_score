import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import 'package:live_score/src/core/extensions/context_ext.dart';

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

  Color getBackground(BuildContext context, int number) {
    Color color = context.colorsExt.grey.withOpacitySafe(0.2);
    if (number == 1) color = context.colorsExt.green;
    if (number == 0) color = context.colorsExt.red;
    if (number == 2) color = context.colorsExt.grey;
    return color;
  }

  Icon? getIcon(BuildContext context, int number) => switch (number) {
    0 => smallIcon(context, Icons.close),
    1 => smallIcon(context, Icons.check),
    2 => smallIcon(context, Icons.remove),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    List<int> formNumbers = [...form];
    formNumbers = formNumbers.reversed.toList();
    while (formNumbers.length < 5) {
      formNumbers.add(-1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: spacing,
      children: List.generate(
        5,
        (index) => getCircle(
          child: getIcon(context, formNumbers[index]),
          color: getBackground(context, formNumbers[index]),
        ),
      ),
    );
  }

  Icon smallIcon(BuildContext context, IconData icon) {
    return Icon(icon, color: context.colorsExt.white, size: itemSize * 0.8);
  }

  Widget getCircle({Widget? child, required Color color}) => Container(
    width: itemSize,
    height: itemSize,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(50),
    ),
    child: child,
  );
}
