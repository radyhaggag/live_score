import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/extensions/color.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/soccer_cubit.dart';
import 'league_card.dart';
import 'modal_sheet_content.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class CircleLeaguesHeader extends StatelessWidget {
  final List<League> leagues;

  const CircleLeaguesHeader({super.key, required this.leagues});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 68,
      padding: const EdgeInsetsDirectional.only(start: 15),
      decoration: BoxDecoration(
        gradient: context.colorsExt.blueGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) =>
                buildLeagueAvatar(league: leagues[index], context: context),
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
        itemCount: leagues.length,
      ),
    );
  }

  Widget buildLeagueAvatar({
    required League league,
    required BuildContext context,
  }) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: InkWell(
      onTap: () {
        buildBottomSheet(
          context: context,
          league: league,
          cubit: context.read<SoccerCubit>(),
        );
      },
      child: CircleAvatar(
        backgroundColor:
            league.color != null
                ? league.color!.toColor
                : context.colorsExt.blueGrey,
        radius: 25,
        child: CustomImage(
          fit: BoxFit.contain,
          width: 25,
          height: 25,
          imageUrl: league.logo,
        ),
      ),
    ),
  );
}

class RectLeaguesHeader extends StatefulWidget {
  final List<League> leagues;
  final bool getFixtures;
  final int? initialSelectedLeagueId;
  final Widget? prefixIcon;
  final VoidCallback? onPrefixIconTap;

  const RectLeaguesHeader({
    super.key,
    required this.leagues,
    required this.getFixtures,
    this.initialSelectedLeagueId,
    this.prefixIcon,
    this.onPrefixIconTap,
  });

  @override
  State<RectLeaguesHeader> createState() => _RectLeaguesHeaderState();
}

class _RectLeaguesHeaderState extends State<RectLeaguesHeader> {
  int? selectedLeagueId;

  @override
  void initState() {
    super.initState();
    selectedLeagueId = widget.initialSelectedLeagueId;
  }

  @override
  void didUpdateWidget(covariant RectLeaguesHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedLeagueId != oldWidget.initialSelectedLeagueId) {
      selectedLeagueId = widget.initialSelectedLeagueId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SizedBox(
        height: 48,
        child: Row(
          spacing: 8,
          children: [
            if (widget.prefixIcon != null)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onPrefixIconTap != null) {
                      widget.onPrefixIconTap!();
                    }
                    setState(() => selectedLeagueId = null);
                  },
                  child: widget.prefixIcon,
                ),
              ),
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.leagues.length,
                separatorBuilder:
                    (_, _) => const SizedBox(width: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final viewCountryName = widget.leagues.any((l) {
                    return l.name == widget.leagues[index].name &&
                        l.id != widget.leagues[index].id;
                  });
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: InkWell(
                      onTap: () {
                        if (widget.getFixtures == false) {
                          final params = StandingsParams(
                            leagueId: widget.leagues[index].id,
                          );
                          context.read<SoccerCubit>().getStandings(params);
                        } else {
                          context.read<SoccerCubit>().getCurrentRoundFixtures(
                            competitionId: widget.leagues[index].id,
                          );
                        }
                        setState(
                          () => selectedLeagueId = widget.leagues[index].id,
                        );
                      },
                      child: LeagueCard(
                        league: widget.leagues[index],
                        isSelected:
                            selectedLeagueId == widget.leagues[index].id,
                        viewCountryName: viewCountryName,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
