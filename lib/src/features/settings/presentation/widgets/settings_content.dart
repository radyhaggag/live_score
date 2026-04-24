import 'package:flutter/material.dart';

import 'settings_language_tile.dart';
import 'settings_theme_tile.dart';
import 'settings_version_footer.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/constants/app_decorations.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top + kToolbarHeight;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(AppSpacing.l, topPadding + AppSpacing.m, AppSpacing.l, AppSpacing.xl),
      children: [
        _SettingsSection(
          title: context.l10n.appearance.toUpperCase(),
          children: const [
            SettingsThemeTile(),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _SettingsSection(
          title: context.l10n.language.toUpperCase(),
          children: const [
            SettingsLanguageTile(),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),
        const SettingsVersionFooter(),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s, bottom: AppSpacing.s),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: context.colorsExt.textMuted,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
          ),
        ),
        Container(
          decoration: AppDecorations.glassMorphism(context).copyWith(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
