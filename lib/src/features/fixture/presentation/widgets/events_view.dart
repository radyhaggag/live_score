import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/fixture_details.dart';
import 'items_not_available.dart';

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
          final player = _firstWhereOrNull(
            details.members,
            (member) => member.id == event.playerId,
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

  T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T item) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return ItemsNotAvailable(
        message: context.l10n.noEvents,
        icon: Icons.event_busy,
        color: widget.color,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder:
            (context, index) =>
                _EventCard(event: events[index], color: widget.color),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.color});

  final Event event;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [_eventTeam(context), _eventDetails(context)],
        ),
      ),
    );
  }

  Widget _eventDetails(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 14,
        backgroundColor: color,
        child: FittedBox(
          child: Text(
            event.gameTimeDisplay,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    event.type.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (event.type.subTypeName != null)
                  Text(
                    event.type.subTypeName ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
              ],
            ),
            if (event.type.id.isGoalOrOwnGoal || event.type.id.isMissedPenalty)
              _eventGoal(context),
            if (event.type.id.isCard) _eventCard(context),
            if (event.type.id.isSubstitute) _eventSubstitute(context),
          ],
        ),
      ),
    ],
  );

  Widget _eventTeam(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomImage(width: 20, height: 20, imageUrl: event.team?.logo ?? ''),
      const SizedBox(width: 10),
      Flexible(
        child: Text(
          event.team?.name.teamName ?? '',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.blueGrey),
        ),
      ),
    ],
  );

  Widget _eventSubstitute(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.red),
        ),
      ),
      const SizedBox(width: 10),
      const Image(width: 28, height: 28, image: AssetImage(AppAssets.subs)),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          event.extraPlayerDetails != null &&
                  event.extraPlayerDetails!.isNotEmpty
              ? event.extraPlayerDetails!.first.name
              : '',
          textAlign: TextAlign.end,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.green),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  Widget _eventCard(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      const SizedBox(width: 10),
      Container(
        color: event.type.id.isYellowCard ? AppColors.yellow : AppColors.red,
        width: 18,
        height: 24,
      ),
    ],
  );

  Widget _eventGoal(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.blue),
        ),
      ),
      const SizedBox(width: 10),
      event.type.id.isGoalOrOwnGoal
          ? const Icon(Icons.sports_soccer, size: 24)
          : _penaltyMissed(),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          event.extraPlayerDetails != null &&
                  event.extraPlayerDetails!.isNotEmpty
              ? "${context.l10n.assist}: ${event.extraPlayerDetails!.map((e) => e.name.playerName).join(', ')}"
              : '',
          textAlign: TextAlign.end,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.green),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );

  Widget _penaltyMissed() => const Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Icon(Icons.sports_soccer, size: 24),
      CircleAvatar(
        radius: 8,
        backgroundColor: AppColors.red,
        child: Icon(Icons.close, color: AppColors.white, size: 10),
      ),
    ],
  );
}
