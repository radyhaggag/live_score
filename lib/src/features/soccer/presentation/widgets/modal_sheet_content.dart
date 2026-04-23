import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:live_score/src/core/layout/adaptive_layout.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/color.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/custom_image.dart';
import '../cubit/soccer_cubit.dart';
import 'sheet_action.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

Future<dynamic> buildBottomSheet({
  required BuildContext context,
  required League league,
  required SoccerCubit cubit,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => ModalSheetContent(league: league, cubit: cubit),
  );
}

class ModalSheetContent extends StatelessWidget {
  final League league;
  final SoccerCubit cubit;

  const ModalSheetContent({
    super.key,
    required this.league,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.isCompactWindow ? double.infinity : 520,
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF102B68), Color(0xFF2C6BED)],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacitySafe(0.18),
                    blurRadius: 30,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 46,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.colorsExt.white.withOpacitySafe(0.6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _LeagueHeader(league: league),
                  const SizedBox(height: AppSpacing.xl),
                  SheetAction(
                    icon: Icons.sports_soccer_rounded,
                    title: l10n.viewFixtures,
                    subtitle: l10n.fixtures,
                    onTap: () {
                      context.push(Routes.fixtures, extra: league.id);
                      context.pop();
                    },
                  ),
                  const SizedBox(height: AppSpacing.m),
                  SheetAction(
                    icon: Icons.bar_chart_rounded,
                    title: l10n.viewStandings,
                    subtitle: l10n.standings,
                    onTap: () {
                      context.push(Routes.standings, extra: league.id);
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeagueHeader extends StatelessWidget {
  const _LeagueHeader({required this.league});
  final League league;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: context.colorsExt.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: CustomImage(width: 34, height: 34, imageUrl: league.logo),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                league.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: context.colorsExt.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                context.l10n.settings,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.colorsExt.white.withValues(alpha: 0.84),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
