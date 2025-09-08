import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/utils/app_colors.dart';

class StandingsForm extends StatelessWidget {
  final List<int> form;

  const StandingsForm({super.key, required this.form});

  Color getBackground(int number) {
    Color color = AppColors.grey.withOpacitySafe(0.2);
    if (number == 1) color = AppColors.green;
    if (number == 0) color = AppColors.red;
    if (number == 2) color = AppColors.grey;
    return color;
  }

  Icon? getIcon(int number) {
    if (number == 1) return smallIcon(Icons.check);

    if (number == 0) return smallIcon(Icons.close);

    if (number == 2) return smallIcon(Icons.remove);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<int> formNumbers = [...form];
    formNumbers = formNumbers.reversed.toList();
    while (formNumbers.length < 5) {
      formNumbers.add(-1);
    }

    return SizedBox(
      width: 110.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            5,
            (index) => getCircle(
              child: getIcon(formNumbers[index]),
              color: getBackground(formNumbers[index]),
            ),
          ),
        ],
      ),
    );
  }

  Icon smallIcon(IconData icon) {
    return Icon(icon, color: AppColors.white, size: 16.radius);
  }

  Widget getCircle({Widget? child, required Color color}) => Container(
    width: 18.radius,
    height: 18.radius,
    margin: const EdgeInsets.only(right: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(50),
    ),
    child: child,
  );
}
