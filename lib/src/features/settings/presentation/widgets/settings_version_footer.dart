import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../cubit/settings_cubit.dart';

class SettingsVersionFooter extends StatelessWidget {
  const SettingsVersionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocSelector<SettingsCubit, SettingsState, String>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        return Center(
          child: Column(
            children: [
              Text(
                AppStrings.appVersion,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                appVersion.isEmpty ? '--' : appVersion,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
