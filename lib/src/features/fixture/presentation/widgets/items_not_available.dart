import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';

class ItemsNotAvailable extends StatelessWidget {
  final IconData icon;
  final String message;

  const ItemsNotAvailable(
      {super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100.radius),
          SizedBox(height: 10.height),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.blueGrey, letterSpacing: 1.1),
          ),
        ],
      ),
    );
  }
}
