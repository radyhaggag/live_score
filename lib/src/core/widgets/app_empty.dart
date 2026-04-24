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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, size: 60, color: color)
            else if (image != null)
              Image(image: image!, width: 60, height: 60)
            else
              const Image(image: AssetImage(AppAssets.noFixtures), width: 60, height: 60),
            const SizedBox(height: AppSpacing.m),
            Text(
              message ?? context.l10n.noFixtures,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(
                color: color ?? context.colorsExt.blueGrey, 
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
