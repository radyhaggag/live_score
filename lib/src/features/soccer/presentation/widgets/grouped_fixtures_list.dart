import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import 'fixture_card.dart';

class GroupedFixturesList extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const GroupedFixturesList({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    final groupedItems = _buildGroupedFixtures(fixtures);

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
          final gameTime = item.startTime.toString();
          final localTime = DateTime.parse(gameTime).toLocal();
          final formattedTime = DateFormat("h:mm a").format(localTime);

          return FixtureCard(soccerFixture: item, fixtureTime: formattedTime);
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Groups fixtures by day and returns a mixed list of [String date headers + fixtures]
  List<dynamic> _buildGroupedFixtures(List<SoccerFixture> fixtures) {
    fixtures.sort((a, b) {
      if (a.startTime == null || b.startTime == null) return 0;
      return a.startTime!.compareTo(b.startTime!);
    });

    List<dynamic> groupedList = [];
    String? lastDate;

    final now = DateTime.now();

    for (var fixture in fixtures) {
      if (fixture.startTime == null) continue;

      final localDate = fixture.startTime!.toLocal();
      final isSameYear = localDate.year == now.year;

      // Format: add year only if not current year
      final fixtureDate = DateFormat(
        isSameYear ? "EEEE, MMM d" : "EEEE, MMM d, yyyy",
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
