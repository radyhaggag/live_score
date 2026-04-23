import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../../../core/utils/app_colors.dart';

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

  Color getBackground(int number) {
    Color color = AppColors.grey.withOpacitySafe(0.2);
    if (number == 1) color = AppColors.green;
    if (number == 0) color = AppColors.red;
    if (number == 2) color = AppColors.grey;
    return color;
  }

  Icon? getIcon(int number) => switch (number) {
    0 => smallIcon(Icons.close),
    1 => smallIcon(Icons.check),
    2 => smallIcon(Icons.remove),
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
          child: getIcon(formNumbers[index]),
          color: getBackground(formNumbers[index]),
        ),
      ),
    );
  }

  Icon smallIcon(IconData icon) {
    return Icon(icon, color: AppColors.white, size: itemSize * 0.8);
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
