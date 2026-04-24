import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/app_l10n.dart';
import '../constants/app_spacing.dart';
import '../constants/app_decorations.dart';
import '../extensions/context_ext.dart';

/// Represents the app empty widget entity/model.
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.message,
    this.icon,
    this.image,
    this.color,
    this.onRetry,
    this.retryLabel,
  });

  final String? message;
  final IconData? icon;
  final Widget? image; // changed to Widget to support other image types
  final Color? color;
  final VoidCallback? onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? context.colorsExt.textMuted;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: AppSpacing.xl),
      decoration: BoxDecoration(
        color: context.colorsExt.surfaceElevated.withValues(alpha: 0.5),
        borderRadius: AppBorderRadius.largeAll,
        border: Border.all(color: context.colorsExt.dividerSubtle),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration / Icon Circle
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeColor.withValues(alpha: 0.1),
            ),
            child: image ?? Icon(
              icon ?? PhosphorIcons.soccerBall(PhosphorIconsStyle.regular),
              size: 64,
              color: themeColor,
            ),
          ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack),
          
          const SizedBox(height: AppSpacing.xl),
          
          Text(
            message ?? context.l10n.noFixtures,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ).animate().fade(delay: 300.ms).slideY(begin: 0.2),
          
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: Icon(PhosphorIcons.arrowsClockwise(PhosphorIconsStyle.bold), size: 18),
              label: Text(retryLabel ?? context.l10n.reload),
              style: FilledButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ).animate().fade(delay: 400.ms).slideY(begin: 0.2),
          ]
        ],
      ),
    );
  }
}
