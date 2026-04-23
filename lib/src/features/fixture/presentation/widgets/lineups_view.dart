import 'package:flutter/material.dart';
import 'package:live_score/src/core/domain/entities/teams.dart';
import 'package:live_score/src/core/extensions/strings.dart';
import 'package:live_score/src/features/fixture/domain/entities/fixture_details.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/app_empty.dart';
import 'teams_lineups.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class LineupsView extends StatelessWidget {
  final FixtureDetails? fixtureDetails;
  final Color? color;

  const LineupsView({super.key, required this.fixtureDetails, this.color});

  @override
  Widget build(BuildContext context) {
    final homeTeam = fixtureDetails?.fixture.teams.home;
    final awayTeam = fixtureDetails?.fixture.teams.away;
    final hasLineups =
        (homeTeam?.lineup?.formation ?? '').isNotEmpty &&
        (awayTeam?.lineup?.formation ?? '').isNotEmpty;

    if (!hasLineups) {
      return AppEmptyWidget(
        icon: Icons.people,
        message: context.l10n.noLineups,
        color: color,
      );
    }

    return Column(
      children: [
        _buildTeamHeader(context: context, team: homeTeam!),
        Container(
          width: double.infinity,
          height: 560,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(AppAssets.playground),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ).copyWith(top: 20),
            child: TeamsLineups(fixtureDetails: fixtureDetails!),
          ),
        ),
        _buildTeamHeader(context: context, team: awayTeam!),
      ],
    );
  }

  Widget _buildTeamHeader({required BuildContext context, required Team team}) {
    return Container(
      color: context.colorsExt.darkGreen,
      padding: const EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          CustomImage(width: 35, height: 35, imageUrl: team.logo),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              team.name.teamName,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: context.colorsExt.white),
            ),
          ),
          Text(
            team.lineup?.formation ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSize.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
