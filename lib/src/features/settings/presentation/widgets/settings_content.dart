import 'package:flutter/material.dart';

import 'settings_theme_tile.dart';
import 'settings_version_footer.dart';

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
        const SizedBox(height: 16),
        Divider(
          height: 1,
          color: colorScheme.onSurface.withValues(alpha: 0.08),
        ),
        const SizedBox(height: 24),
        const SettingsVersionFooter(),
        const SizedBox(height: 40),
      ],
    );
  }
}
