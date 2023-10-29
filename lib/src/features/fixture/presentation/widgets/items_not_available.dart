import 'package:flutter/material.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';

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
          Icon(icon, size: AppSize.s100),
          const SizedBox(height: AppSize.s10),
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
