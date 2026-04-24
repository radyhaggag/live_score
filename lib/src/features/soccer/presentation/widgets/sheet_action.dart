import 'package:live_score/src/core/extensions/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_ext.dart';

/// A sheet action button row used in the league bottom sheet.
class SheetAction extends StatelessWidget {
  const SheetAction({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.l),
            decoration: BoxDecoration(
              color: context.colorsExt.white.withOpacitySafe(0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: context.colorsExt.white.withOpacitySafe(0.18),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: context.colorsExt.white.withOpacitySafe(0.15),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(icon, color: context.colorsExt.white),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: context.colorsExt.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: context.colorsExt.white.withOpacitySafe(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colorsExt.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
