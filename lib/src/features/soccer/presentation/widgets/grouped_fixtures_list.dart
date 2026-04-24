import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/config/app_route.dart';
import 'package:flutter/services.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/theme/app_fonts.dart';
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
    final groupedItems = _buildGroupedFixtures(
      fixtures,
      localeName: context.localeName,
    );

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 120),
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        final item = groupedItems[index];
        return switch (item) {
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
          FixtureCardItem(fixture: final fixture) => () {
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
                context.push(Routes.fixtureDetails, extra: item.fixture);
              },
              child: FixtureCard(
                soccerFixture: fixture,
                fixtureTime: formattedTime,
                showLeagueLogo: showLeagueLogo,
              ),
            );
          }(),
        };
      },
    );
  }
}

/// Groups fixtures by day and returns a mixed list of [FixtureHeaderItem] and [FixtureCardItem]
List<GroupedFixtureItem> _buildGroupedFixtures(
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

    // Format: add year only if not current year
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
