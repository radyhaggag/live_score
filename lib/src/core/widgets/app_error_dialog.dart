import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_l10n.dart';
import '../extensions/context_ext.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

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
        return AlertDialog(
          content: AppErrorDialog(message: message, onRetry: onRetry),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, color: context.colorsExt.red, size: 90),
        const SizedBox(height: AppSpacing.s),
        Text(
          context.l10n.errorMessage(message),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.s),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorsExt.blue,
            ),
            onPressed: () {
              onRetry?.call();
              context.pop();
            },
            child: Text(
              context.l10n.reload,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: context.colorsExt.white),
            ),
          ),
        ),
      ],
    );
  }
}
