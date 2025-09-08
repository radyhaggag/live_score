import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/league.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/use_cases/standings_usecase.dart';
import '../cubit/soccer_cubit.dart';
import 'league_card.dart';
import 'modal_sheet_content.dart';

class RectLeaguesHeader extends StatelessWidget {
  final List<League> leagues;

  const RectLeaguesHeader({super.key, required this.leagues});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.s90,
      padding: const EdgeInsetsDirectional.only(start: AppPadding.p10),
      decoration: const BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSize.s50),
          topLeft: Radius.circular(AppSize.s50),
        ),
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildLeagueAvatar(league: leagues[index], context: context);
        },
        separatorBuilder: (_, _) => const SizedBox(width: AppSize.s10),
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
      backgroundColor: hexToColor(league.hexColor),
      radius: AppSize.s35,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        width: AppSize.s40,
        height: AppSize.s40,
        imageUrl: league.logo,
      ),
    ),
  );

  Color hexToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse(hex, radix: 16));
  }
}

class CircleLeaguesHeader extends StatelessWidget {
  final List<League> leagues;
  final bool getFixtures;

  const CircleLeaguesHeader({
    super.key,
    required this.leagues,
    required this.getFixtures,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p5,
        horizontal: AppPadding.p5,
      ),
      child: SizedBox(
        height: AppSize.s50,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: leagues.length,
          separatorBuilder: (context, index) {
            return const SizedBox(width: AppSize.s5);
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
