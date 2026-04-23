import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../domain/app_language.dart';
import '../cubit/settings_cubit.dart';

class LanguageModeBottomSheet extends StatelessWidget {
  const LanguageModeBottomSheet({super.key, required this.currentLanguage});

  final AppLanguage currentLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

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
                l10n.language,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Text(
                l10n.languageDescription,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
            const SizedBox(height: 16),
            LanguageOptionTile(
              title: l10n.languageLabel(AppLanguage.system),
              icon: Icons.settings_suggest_rounded,
              language: AppLanguage.system,
              currentLanguage: currentLanguage,
            ),
            LanguageOptionTile(
              title: l10n.languageLabel(AppLanguage.english),
              icon: Icons.language_rounded,
              language: AppLanguage.english,
              currentLanguage: currentLanguage,
            ),
            LanguageOptionTile(
              title: l10n.languageLabel(AppLanguage.arabic),
              icon: Icons.translate_rounded,
              language: AppLanguage.arabic,
              currentLanguage: currentLanguage,
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.language,
    required this.currentLanguage,
  });

  final String title;
  final IconData icon;
  final AppLanguage language;
  final AppLanguage currentLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = currentLanguage == language;

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
        context.read<SettingsCubit>().setLanguage(language);
        Navigator.pop(context);
      },
    );
  }
}
