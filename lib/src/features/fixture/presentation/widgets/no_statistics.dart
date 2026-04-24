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
      height: context.screenHeight / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(AppAssets.noStats),
            width: 100.w,
            height: 100.h,
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            context.l10n.noStats,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.colorsExt.blueGrey,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
