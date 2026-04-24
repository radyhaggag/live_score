import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/constants/app_assets.dart';

/// Shown when no statistics are available for the selected fixture.
class NoStatistics extends StatelessWidget {
  const NoStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(AppAssets.noStats),
              width: 60.w,
              height: 60.h,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              context.l10n.noStats,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: context.colorsExt.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
