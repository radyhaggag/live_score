import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

import '../../../../core/utils/app_strings.dart';

class ViewAllTile extends StatelessWidget {
  final VoidCallback onTap;

  const ViewAllTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(horizontal: 10.width),
          surfaceTintColor: AppColors.grey,
          foregroundColor: AppColors.grey,
        ),
        child: Row(
          children: [
            Text(
              AppStrings.viewAll,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(width: 2.width),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 12.radius,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
