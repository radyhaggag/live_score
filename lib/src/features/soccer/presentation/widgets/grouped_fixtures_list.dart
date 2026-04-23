import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:live_score/src/config/app_route.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import 'fixture_card.dart';

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
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        final item = groupedItems[index];
        if (item is String) {
          // Date header
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeights.semiBold,
                color: AppColors.lightRed,
              ),
            ),
          );
        } else if (item is SoccerFixture) {
          // Fixture card
          final localTime = item.startTime?.toLocal();
          final formattedTime =
              localTime == null
                  ? context.l10n.tbd
                  : DateFormat('h:mm a', context.localeName).format(localTime);

          return InkWell(
            onTap: () {
              context.push(Routes.fixtureDetails, extra: item);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FixtureCard(
                soccerFixture: item,
                fixtureTime: formattedTime,
                showLeagueLogo: showLeagueLogo,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Groups fixtures by day and returns a mixed list of [String date headers + fixtures]
  List<dynamic> _buildGroupedFixtures(
    List<SoccerFixture> fixtures, {
    required String localeName,
  }) {
    final sortedFixtures = List<SoccerFixture>.from(fixtures);
    sortedFixtures.sort((a, b) {
      if (a.startTime == null || b.startTime == null) return 0;
      return a.startTime!.compareTo(b.startTime!);
    });

    final List<dynamic> groupedList = [];
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
        groupedList.add(fixtureDate); // Add header
        lastDate = fixtureDate;
      }
      groupedList.add(fixture);
    }

    return groupedList;
  }
}
