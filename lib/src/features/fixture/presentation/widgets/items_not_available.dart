import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/media_query.dart';

class ItemsNotAvailable extends StatelessWidget {
  final IconData icon;
  final String message;

  final Color? color;

  const ItemsNotAvailable({
    super.key,
    required this.icon,
    required this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100.radius, color: color),
          SizedBox(height: 10.height),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
