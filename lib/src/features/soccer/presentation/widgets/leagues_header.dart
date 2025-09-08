import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/utils/app_colors.dart';
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
          if(index == leagues.length - 1){
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
      backgroundColor: HexColor(league.hexColor),
      radius: 25.radius,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        width: 25.radius,
        height: 25.radius,
        imageUrl: league.logo,
      ),
    ),
  );
}

class RectLeaguesHeader extends StatelessWidget {
  final List<League> leagues;
  final bool getFixtures;

  const RectLeaguesHeader({
    super.key,
    required this.leagues,
    required this.getFixtures,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SizedBox(
        height: 40.height,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: leagues.length,
          separatorBuilder: (_, _) {
            return SizedBox(width: 5.width);
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap:
                  getFixtures == false
                      ? () async {
                        StandingsParams params = StandingsParams(
                          leagueId: leagues[index].id.toString(),
                        );
                        await context.read<SoccerCubit>().getStandings(params);
                      }
                      : () => context.read<SoccerCubit>().loadCurrentFixtures(
                        leagues[index].id,
                      ),
              child: LeagueCard(league: leagues[index]),
            );
          },
        ),
      ),
    );
  }
}
