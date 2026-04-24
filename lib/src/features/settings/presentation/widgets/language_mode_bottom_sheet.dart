import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../domain/app_language.dart';
import '../cubit/settings_cubit.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import 'dart:ui';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LanguageModeBottomSheet extends StatelessWidget {
  const LanguageModeBottomSheet({super.key, required this.currentLanguage});

  final AppLanguage currentLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface.withValues(alpha: 0.8),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: context.colorsExt.dividerSubtle, width: 1),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.l,
          top: AppSpacing.s,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.l),
              decoration: BoxDecoration(
                color: context.colorsExt.textMuted.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.language,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.languageDescription,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.colorsExt.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _LanguageOption(
              title: l10n.languageLabel(AppLanguage.system),
              icon: PhosphorIcons.gear(PhosphorIconsStyle.regular),
              language: AppLanguage.system,
              isSelected: currentLanguage == AppLanguage.system,
            ),
            _LanguageOption(
              title: l10n.languageLabel(AppLanguage.english),
              icon: PhosphorIcons.globe(PhosphorIconsStyle.regular),
              language: AppLanguage.english,
              isSelected: currentLanguage == AppLanguage.english,
            ),
            _LanguageOption(
              title: l10n.languageLabel(AppLanguage.arabic),
              icon: PhosphorIcons.translate(PhosphorIconsStyle.regular),
              language: AppLanguage.arabic,
              isSelected: currentLanguage == AppLanguage.arabic,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.icon,
    required this.language,
    required this.isSelected,
  });

  final String title;
  final IconData icon;
  final AppLanguage language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.xs),
      child: InkWell(
        onTap: () {
          context.read<SettingsCubit>().setLanguage(language);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.m),
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? context.colors.primary.withValues(alpha: 0.2) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? context.colors.primary : context.colorsExt.textMuted,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? context.colors.primary : context.colors.onSurface,
                      ),
                ),
              ),
              if (isSelected)
                Icon(
                  PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                  color: context.colors.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
