import 'package:flutter/material.dart';

import 'settings_language_tile.dart';
import 'settings_theme_tile.dart';
import 'settings_version_footer.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        const SettingsThemeTile(),
        const SettingsLanguageTile(),
        const SizedBox(height: AppSpacing.l),
        Divider(
          height: 1,
          color: colorScheme.onSurface.withValues(alpha: 0.08),
        ),
        const SizedBox(height: AppSpacing.xxl),
        const SettingsVersionFooter(),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
