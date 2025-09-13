import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/soccer_cubit.dart';
import 'league_card.dart';
import 'modal_sheet_content.dart';

class CircleLeaguesHeader extends StatelessWidget {
  final List<League> leagues;

  const CircleLeaguesHeader({super.key, required this.leagues});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.height,
      padding: const EdgeInsetsDirectional.only(start: 15),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.radius),
          topLeft: Radius.circular(50.radius),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == leagues.length - 1) {
            return Row(
              children: [
                buildLeagueAvatar(league: leagues[index], context: context),
                SizedBox(width: 10.width),
              ],
            );
          }
          return buildLeagueAvatar(league: leagues[index], context: context);
        },
        separatorBuilder: (_, _) => SizedBox(width: 10.width),
        itemCount: leagues.length,
      ),
    );
  }

  Widget buildLeagueAvatar({
    required League league,
    required BuildContext context,
  }) => InkWell(
    onTap: () {
      buildBottomSheet(
        context: context,
        league: league,
        cubit: context.read<SoccerCubit>(),
      );
    },
    child: CircleAvatar(
      backgroundColor:
          league.color != null ? HexColor(league.color!) : AppColors.blueGrey,
      radius: 25.radius,
      child: CustomImage(
        fit: BoxFit.contain,
        width: 25.radius,
        height: 25.radius,
        imageUrl: league.logo,
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
  initState() {
    super.initState();
    selectedLeagueId = widget.initialSelectedLeagueId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SizedBox(
        height: 40.height,
        child: Row(
          children: [
            if (widget.prefixIcon != null) ...[
              GestureDetector(
                onTap: () {
                  if (widget.onPrefixIconTap != null) {
                    widget.onPrefixIconTap!();
                  }
                  setState(() => selectedLeagueId = null);
                },
                child: widget.prefixIcon,
              ),
              SizedBox(width: 5.width),
            ],
            Expanded(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.leagues.length,
                separatorBuilder: (_, _) {
                  return SizedBox(width: 5.width);
                },
                itemBuilder: (context, index) {
                  final viewCountryName = widget.leagues.any((l) {
                    return l.name == widget.leagues[index].name &&
                        l.id != widget.leagues[index].id;
                  });
                  return InkWell(
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
                      isSelected: selectedLeagueId == widget.leagues[index].id,
                      viewCountryName: viewCountryName,
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
