import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDialog({super.key, required this.message, this.onRetry});

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
          content: ErrorDialog(message: message, onRetry: onRetry),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error_outline, color: AppColors.red, size: 90.radius),
        SizedBox(height: 10.height),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 10.height),
        SizedBox(
          width: context.width / 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              onRetry?.call();
              context.pop();
            },
            child: Text(
              AppStrings.reload,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
