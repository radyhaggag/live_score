import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../cubit/settings_cubit.dart';
import 'theme_mode_bottom_sheet.dart';

class SettingsThemeTile extends StatelessWidget {
  const SettingsThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
      selector: (state) => state.themeMode,
      builder: (context, themeMode) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => ThemeModeBottomSheet(currentThemeMode: themeMode),
            );
          },
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.palette_outlined,
              size: 24,
              color: colorScheme.primary,
            ),
          ),
          title: Text(
            AppStrings.appearance,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              switch (themeMode) {
                ThemeMode.system => AppStrings.systemDefault,
                ThemeMode.light => AppStrings.light,
                ThemeMode.dark => AppStrings.dark,
              },
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: colorScheme.onSurface.withValues(alpha: 0.3),
          ),
        );
      },
    );
  }
}
