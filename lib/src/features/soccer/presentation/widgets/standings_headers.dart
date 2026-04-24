import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/color.dart';
import 'package:live_score/src/core/l10n/app_l10n.dart';
import 'package:live_score/src/core/extensions/context_ext.dart';

import 'standings_metrics.dart';

/// Header row for the standings table with column labels.
class StandingsHeaders extends StatelessWidget {
  const StandingsHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = StandingsMetrics.fromWidth(constraints.maxWidth);
        final headers = [
          context.l10n.playedShort,
          context.l10n.wonShort,
          context.l10n.drawnShort,
          context.l10n.lostShort,
          context.l10n.goalsForShort,
          context.l10n.goalsAgainstShort,
          context.l10n.goalDifferenceShort,
          context.l10n.pointsShort,
        ];
        
        // Use full text for tooltips based on what they represent
        final tooltips = [
          'Played', // Replace with l10n full strings if available, assuming English for now since l10n lacks full strings
          'Won',
          'Drawn',
          'Lost',
          'Goals For',
          'Goals Against',
          'Goal Difference',
          'Points',
        ];

        return Container(
          decoration: BoxDecoration(
            color: context.colorsExt.surfaceElevated,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacitySafe(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            vertical: metrics.headerVerticalPadding,
            horizontal: metrics.headerHorizontalPadding,
          ),
          child: Row(
            children: [
              SizedBox(
                width: metrics.teamColumnWidth,
                child: Row(
                  spacing: metrics.teamContentSpacing,
                  children: [
                    Text('#', style: _getHeaderTextStyle(context)),
                    Text(
                      context.l10n.teamName,
                      style: _getHeaderTextStyle(context),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                headers.length,
                (index) => SizedBox(
                  width: metrics.statColumnWidth,
                  child: Tooltip(
                    message: tooltips[index],
                    child: Text(
                      headers[index],
                      textAlign: TextAlign.center,
                      style: _getHeaderTextStyle(context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: metrics.formColumnWidth,
                child: Text(
                  context.l10n.form,
                  textAlign: TextAlign.center,
                  style: _getHeaderTextStyle(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle? _getHeaderTextStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold);
  }
}
