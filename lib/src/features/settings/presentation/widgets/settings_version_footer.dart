import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../cubit/settings_cubit.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import 'package:live_score/src/core/extensions/context_ext.dart';

class SettingsVersionFooter extends StatelessWidget {
  const SettingsVersionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return BlocSelector<SettingsCubit, SettingsState, String>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        return Center(
          child: Column(
            children: [
              Text(
                l10n.appVersion.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: context.colorsExt.textMuted,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.s),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colorsExt.surfaceGlass,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colorsExt.dividerSubtle),
                ),
                child: Text(
                  appVersion.isEmpty ? 'v1.0.0' : 'v$appVersion',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monospace',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
