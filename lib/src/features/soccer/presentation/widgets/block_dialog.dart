import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class BlockAlert extends StatelessWidget {
  final String message;

  const BlockAlert({super.key, required this.message});

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

void buildBlockAlert({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(content: BlockAlert(message: message)),
  );
}
