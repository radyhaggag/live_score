import 'package:flutter/material.dart';

import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/constants/app_assets.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Shows when no statistics are available.
class NoStatistics extends StatelessWidget {
  const NoStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(AppAssets.noStats),
            width: 100,
            height: 100,
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
