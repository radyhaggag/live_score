import 'package:flutter/material.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

import '../../../../core/l10n/app_l10n.dart';

class ViewAllTile extends StatelessWidget {
  final VoidCallback onTap;

  const ViewAllTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          surfaceTintColor: AppColors.grey,
          foregroundColor: AppColors.grey,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(
              context.l10n.viewAll,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 12,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
