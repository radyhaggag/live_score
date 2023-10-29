import 'package:flutter/material.dart';

import '../../../../config/app_route.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';

class BlockAlert extends StatelessWidget {
  final String message;

  const BlockAlert({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error_outline,
          color: AppColors.red,
          size: AppSize.s90,
        ),
        const SizedBox(height: AppSize.s10),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSize.s10),
        SizedBox(
          width: context.width / 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Routes.soccerLayout);
            },
            child: const Text(AppStrings.reload),
          ),
        ),
      ],
    );
  }
}

void buildBlockAlert({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      content: BlockAlert(message: message),
    ),
  );
}
