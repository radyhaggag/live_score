import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/app_l10n.dart';
import '../extensions/context_ext.dart';
import '../constants/app_spacing.dart';
import '../constants/app_decorations.dart';

/// Represents the app error dialog entity/model.
class AppErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorDialog({super.key, required this.message, this.onRetry});

  static Future<void> show({
    required BuildContext context,
    required String message,
    VoidCallback? onRetry,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent, // Handled by container
          elevation: 0,
          child: AppErrorDialog(message: message, onRetry: onRetry),
        ).animate().scale(curve: Curves.easeOutBack);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorsExt.surfaceElevated,
        borderRadius: AppBorderRadius.largeAll,
        boxShadow: const [AppShadows.floatingShadow],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header strip
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: context.colorsExt.liveGradient,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorsExt.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.warningCircle(PhosphorIconsStyle.fill), 
                    color: context.colorsExt.red, 
                    size: 48
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .scale(end: const Offset(1.05, 1.05), duration: 1.seconds),
                
                const SizedBox(height: AppSpacing.xl),
                
                Text(
                  context.l10n.errorMessage(message),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: AppSpacing.xxl),
                
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: context.colors.onSurface,
                      foregroundColor: context.colors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.mediumAll,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      onRetry?.call();
                      context.pop();
                    },
                    child: Text(
                      context.l10n.reload,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
