import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../cubit/settings_cubit.dart';

class ThemeModeBottomSheet extends StatelessWidget {
  const ThemeModeBottomSheet({super.key, required this.currentThemeMode});

  final ThemeMode currentThemeMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                AppStrings.appearance,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Text(
                AppStrings.appearanceDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ThemeModeOptionTile(
              title: AppStrings.systemDefault,
              icon: Icons.brightness_auto_rounded,
              mode: ThemeMode.system,
              currentThemeMode: currentThemeMode,
            ),
            ThemeModeOptionTile(
              title: AppStrings.light,
              icon: Icons.light_mode_rounded,
              mode: ThemeMode.light,
              currentThemeMode: currentThemeMode,
            ),
            ThemeModeOptionTile(
              title: AppStrings.dark,
              icon: Icons.dark_mode_rounded,
              mode: ThemeMode.dark,
              currentThemeMode: currentThemeMode,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeModeOptionTile extends StatelessWidget {
  const ThemeModeOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.mode,
    required this.currentThemeMode,
  });

  final String title;
  final IconData icon;
  final ThemeMode mode;
  final ThemeMode currentThemeMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = currentThemeMode == mode;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(
        icon,
        color:
            isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      trailing:
          isSelected
              ? Icon(Icons.check_circle_rounded, color: colorScheme.primary)
              : null,
      onTap: () {
        context.read<SettingsCubit>().setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }
}
