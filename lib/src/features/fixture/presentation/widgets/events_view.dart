import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/app_empty.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/fixture_details.dart';
import 'event_card.dart';

class EventsView extends StatefulWidget {
  final FixtureDetails? fixtureDetails;
  final Color color;

  const EventsView({
    super.key,
    required this.fixtureDetails,
    required this.color,
  });

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _mapEvents();
  }

  @override
  void didUpdateWidget(covariant EventsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fixtureDetails != widget.fixtureDetails) {
      _mapEvents();
    }
  }

  void _mapEvents() {
    final details = widget.fixtureDetails;
    if (details == null) {
      events = [];
      return;
    }

    events =
        details.sortedEvents.map((event) {
          final player = details.members.cast<dynamic>().firstWhere(
            (member) => member.id == event.playerId,
            orElse: () => null,
          );
          final teams = details.fixture.teams;
          final team = teams.home.id == event.teamId ? teams.home : teams.away;
          final extraPlayers =
              details.members
                  .where((member) => event.extraPlayers.contains(member.id))
                  .toList();

          return event.copyWith(
            player: player,
            team: team,
            extraPlayerDetails: extraPlayers,
          );
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return AppEmptyWidget(
        message: context.l10n.noEvents,
        icon: Icons.event_busy,
        color: widget.color,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.l),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: events.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final event = events[index];
          final isHomeTeam = event.team?.id == widget.fixtureDetails?.fixture.teams.home.id;
          final isLast = index == events.length - 1;

          return EventCard(
            event: event,
            color: widget.color,
            isHomeTeam: isHomeTeam,
            isLast: isLast,
          )
          .animate()
          .fade(duration: 400.ms, delay: (50 * index).ms)
          .slideY(begin: 0.1);
        },
      ),
    );
  }
}
