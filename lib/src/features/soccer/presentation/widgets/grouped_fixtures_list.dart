import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:flutter/services.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';
import 'package:live_score/src/core/utils/app_animations.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/domain/entities/league.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/color.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/constants/app_decorations.dart';
import '../../../../core/widgets/custom_image.dart';
import 'fixture_card.dart';

sealed class GroupedFixtureItem {
  const GroupedFixtureItem();
}

class FixtureHeaderItem extends GroupedFixtureItem {
  final String date;
  const FixtureHeaderItem(this.date);
}

class FixtureCardItem extends GroupedFixtureItem {
  final SoccerFixture fixture;
  const FixtureCardItem(this.fixture);
}

class GroupedFixturesList extends StatelessWidget {
  final List<SoccerFixture> fixtures;
  final bool showLeagueLogo;

  const GroupedFixturesList({
    super.key,
    required this.fixtures,
    this.showLeagueLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    if (fixtures.isEmpty) {
      return const SizedBox.shrink();
    }

    // Determine if we should group by League or Date
    // If all fixtures have the same league, group by Date.
    // If there are multiple leagues, group by League.
    final firstLeagueId = fixtures.first.fixtureLeague.id;
    final allSameLeague = fixtures.every((f) => f.fixtureLeague.id == firstLeagueId);

    if (allSameLeague) {
      return _buildDateGroupedList(context);
    } else {
      return _buildLeagueGroupedList(context);
    }
  }

  Widget _buildDateGroupedList(BuildContext context) {
    final groupedItems = _buildGroupedFixturesByDate(
      fixtures,
      localeName: context.localeName,
    );

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 120),
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        final item = groupedItems[index];
        final widget = switch (item) {
          FixtureHeaderItem(date: final date) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.m,
              horizontal: AppSpacing.m,
            ),
            child: Text(
              date,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeights.semiBold,
                color: context.colors.secondary,
              ),
            ),
          ),
          FixtureCardItem(fixture: final fixture) => _buildFixtureCard(context, fixture),
        };

        return FadeSlideIn(
          delay: Duration(milliseconds: 30 * index.clamp(0, 15)),
          child: widget,
        );
      },
    );
  }

  Widget _buildLeagueGroupedList(BuildContext context) {
    final groups = _buildGroupedFixturesByLeague(fixtures);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        for (int i = 0; i < groups.length; i++)
          SliverMainAxisGroup(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _LeagueHeaderDelegate(
                  league: groups[i].league,
                  context: context,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final fixture = groups[i].fixtures[index];
                    return FadeSlideIn(
                      delay: Duration(milliseconds: 30 * index.clamp(0, 10)),
                      child: Column(
                        children: [
                          _buildFixtureCard(context, fixture),
                          if (index < groups[i].fixtures.length - 1)
                            Divider(
                              color: context.colorsExt.dividerSubtle,
                              height: 1,
                              thickness: 1,
                              indent: AppSpacing.xxl,
                              endIndent: AppSpacing.l,
                            ),
                        ],
                      ),
                    );
                  },
                  childCount: groups[i].fixtures.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.xl),
              ),
            ],
          ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 120), // Bottom padding
        ),
      ],
    );
  }

  Widget _buildFixtureCard(BuildContext context, SoccerFixture fixture) {
    final localTime = fixture.startTime?.toLocal();
    final formattedTime =
        localTime == null
            ? context.l10n.tbd
            : DateFormat(
              'h:mm a',
              context.localeName,
            ).format(localTime);

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        context.push(Routes.fixtureDetails, extra: fixture);
      },
      child: FixtureCard(
        soccerFixture: fixture,
        fixtureTime: formattedTime,
        showLeagueLogo: showLeagueLogo,
      ),
    );
  }
}

class _LeagueGroup {
  final League league;
  final List<SoccerFixture> fixtures;

  _LeagueGroup(this.league, this.fixtures);
}

List<_LeagueGroup> _buildGroupedFixturesByLeague(List<SoccerFixture> fixtures) {
  final map = <int, _LeagueGroup>{};
  for (final fixture in fixtures) {
    final league = fixture.fixtureLeague;
    if (!map.containsKey(league.id)) {
      map[league.id] = _LeagueGroup(league, []);
    }
    map[league.id]!.fixtures.add(fixture);
  }
  return map.values.toList();
}

List<GroupedFixtureItem> _buildGroupedFixturesByDate(
  List<SoccerFixture> fixtures, {
  required String localeName,
}) {
  final sortedFixtures = List<SoccerFixture>.from(fixtures);
  sortedFixtures.sort((a, b) {
    if (a.startTime == null || b.startTime == null) return 0;
    return a.startTime!.compareTo(b.startTime!);
  });

  final List<GroupedFixtureItem> groupedList = [];
  String? lastDate;

  final now = DateTime.now();

  for (final fixture in sortedFixtures) {
    if (fixture.startTime == null) continue;

    final localDate = fixture.startTime!.toLocal();
    final isSameYear = localDate.year == now.year;

    final fixtureDate = DateFormat(
      isSameYear ? 'EEEE, MMM d' : 'EEEE, MMM d, yyyy',
      localeName,
    ).format(localDate);

    if (lastDate != fixtureDate) {
      groupedList.add(FixtureHeaderItem(fixtureDate));
      lastDate = fixtureDate;
    }
    groupedList.add(FixtureCardItem(fixture));
  }

  return groupedList;
}

class _LeagueHeaderDelegate extends SliverPersistentHeaderDelegate {
  final League league;
  final BuildContext context;

  _LeagueHeaderDelegate({required this.league, required this.context});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Gradient bar + logo
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        gradient: LinearGradient(
          colors: [
            context.colors.surface,
            context.colorsExt.surfaceGlass.withOpacitySafe(0.8),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacitySafe(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.s,
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: context.colors.surface,
              shape: BoxShape.circle,
              boxShadow: const [AppShadows.elevatedShadow],
            ),
            child: Center(
              child: CustomImage(
                imageUrl: league.logo,
                width: 18,
                height: 18,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Text(
              league.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant _LeagueHeaderDelegate oldDelegate) {
    return league.id != oldDelegate.league.id;
  }
}
