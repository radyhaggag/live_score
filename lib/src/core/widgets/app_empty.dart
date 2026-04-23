import 'package:flutter/material.dart';

import '../l10n/app_l10n.dart';
import '../constants/app_assets.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

/// Represents the app empty widget entity/model.
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.message,
    this.icon,
    this.image,
    this.color,
  });

  final String? message;
  final IconData? icon;
  final AssetImage? image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(icon, size: 100, color: color)
        else if (image != null)
          Image(image: image!)
        else
          const Image(image: AssetImage(AppAssets.noFixtures)),
        const SizedBox(height: AppSpacing.s),
        Text(
          message ?? context.l10n.noFixtures,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: color, letterSpacing: 1.1),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
