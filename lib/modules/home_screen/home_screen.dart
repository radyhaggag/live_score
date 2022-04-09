import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_score/layout/cubit/cubit.dart';
import 'package:live_score/layout/cubit/states.dart';

import '../../layout/matches_layout/matches_layout.dart';
import '../../shared/components/league_item.dart';
import '../../shared/components/live_match_card.dart';
import '../../shared/components/match_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveScoreCubit, LiveScoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LiveScoreCubit cubit = LiveScoreCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 90,
                padding: const EdgeInsetsDirectional.only(start: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 19, 62, 153),
                        Color(0xFF4373D9)
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    topLeft: Radius.circular(50.0),
                  ),
                ),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildLeagueItem(cubit.leagues[index], context, cubit),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: cubit.leagues.length,
                ),
              ),
              const SizedBox(height: 10),
              if (cubit.liveMatches.isNotEmpty)
                Row(
                  children: [
                    Text(
                      "Live Matches",
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        cubit.leagueId = 0;
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => const MatchesLayout(),
                              ),
                            )
                            .then((value) {});
                      },
                      child: Row(
                        children: [
                          Text(
                            "VIEW ALL",
                            style: Theme.of(context).textTheme.labelLarge!,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 17,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ],
                ),
              if (cubit.liveMatches.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildLiveMatchCard(cubit.liveMatches[index], context),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: cubit.liveMatches.length,
                  ),
                ),
              if (cubit.matches.isNotEmpty)
                Row(
                  children: [
                    Text(
                      "Matches",
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        cubit.leagueId = 0;

                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => const MatchesLayout(),
                              ),
                            )
                            .then((value) {});
                      },
                      child: Row(
                        children: [
                          Text(
                            "VIEW ALL",
                            style: Theme.of(context).textTheme.labelLarge!,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 17,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ],
                ),
              (cubit.matches.isNotEmpty)
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              buildMatchCard(cubit.matches[index], context),
                          itemCount: cubit.matches.length,
                        ),
                      ),
                    )
                  : Expanded(
                      child: (state is LiveScoreGetFixturesSuccessState)
                          ? Image.asset("assets/images/no_matches.webp")
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
