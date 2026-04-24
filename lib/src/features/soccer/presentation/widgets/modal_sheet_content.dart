import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';
import 'package:live_score/src/core/extensions/responsive_size.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/custom_image.dart';
import '../cubit/soccer/soccer_cubit.dart';
import 'sheet_action.dart';

/// Sheet drag handle width and height constants.
const double _kDragHandleWidth = 46;
const double _kDragHandleHeight = 5;

Future<dynamic> buildBottomSheet({
  required BuildContext context,
  required League league,
  required SoccerCubit cubit,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    elevation: 0,
    isScrollControlled: true,
    useRootNavigator: true,
    showDragHandle: false,
    builder: (context) => SafeArea(
      bottom: true,
      child: ModalSheetContent(league: league, cubit: cubit),
    ),
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

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF102B68), Color(0xFF2C6BED)],
          ),
          borderRadius: BorderRadius.circular(28.r),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: _kDragHandleWidth,
                height: _kDragHandleHeight,
                decoration: BoxDecoration(
                  color: context.colorsExt.white.withOpacitySafe(0.6),
                  borderRadius: BorderRadius.circular(999.r),
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
                HapticFeedback.selectionClick();
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
                HapticFeedback.selectionClick();
                context.push(Routes.standings, extra: league.id);
                context.pop();
              },
            ),
          ],
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
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: context.colorsExt.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Center(
            child: CustomImage(
              width: 34.w,
              height: 34.h,
              imageUrl: league.logo,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.m),
        Text(
          league.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: context.colorsExt.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
