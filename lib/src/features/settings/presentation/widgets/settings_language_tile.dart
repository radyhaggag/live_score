import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../domain/app_language.dart';
import '../cubit/settings_cubit.dart';
import 'language_mode_bottom_sheet.dart';

import '../../../../core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsLanguageTile extends StatelessWidget {
  const SettingsLanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return BlocSelector<SettingsCubit, SettingsState, AppLanguage>(
      selector: (state) => state.language,
      builder: (context, language) {
        return InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) => LanguageModeBottomSheet(currentLanguage: language),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.l),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    PhosphorIcons.translate(PhosphorIconsStyle.regular),
                    size: 24,
                    color: context.colors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.language,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.languageLabel(language),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: context.colorsExt.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                  size: 18,
                  color: context.colorsExt.textMuted.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
