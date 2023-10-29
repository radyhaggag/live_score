import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';

class StandingsForm extends StatelessWidget {
  final String? form;

  const StandingsForm({super.key, required this.form});

  Color getBackground(String letter) {
    Color color = AppColors.grey.withOpacity(0.2);
    if (letter == "W") color = AppColors.green;
    if (letter == "L") color = AppColors.red;
    if (letter == "D") color = AppColors.grey;
    return color;
  }

  Icon? getIcon(String letter) {
    if (letter == "W") return smallIcon(Icons.check);

    if (letter == "L") return smallIcon(Icons.close);

    if (letter == "D") return smallIcon(Icons.remove);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String>? formLetters = form?.split("").reversed.toList();
    while (formLetters != null && formLetters.length < 5) {
      formLetters.add("");
    }

    return SizedBox(
      width: AppSize.s110,
      child: formLetters != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  5,
                  (index) => getCircle(
                    child: getIcon(formLetters[index]),
                    color: getBackground(formLetters[index]),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                  5,
                  (index) => getCircle(
                    color: AppColors.grey.withOpacity(.2),
                  ),
                ),
              ],
            ),
    );
  }
}

Icon smallIcon(IconData icon) =>
    Icon(icon, color: AppColors.white, size: AppSize.s16);

Widget getCircle({Widget? child, required Color color}) => Container(
      width: AppSize.s18,
      height: AppSize.s18,
      margin: const EdgeInsets.only(right: AppPadding.p2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
