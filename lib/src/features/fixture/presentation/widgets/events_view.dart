import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';
import 'package:live_score/src/core/extensions/strings.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
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
    final fetchedEvents = widget.fixtureDetails?.sortedEvents ?? [];
    if (widget.fixtureDetails == null) return;
    events =
        fetchedEvents.map((event) {
          // Main player
          final player = widget.fixtureDetails!.members.firstWhere(
            (member) => member.id == event.playerId,
          );
          // Main team
          final teams = widget.fixtureDetails!.fixture.teams;
          final team = teams.home.id == event.teamId ? teams.home : teams.away;
          // Extra players
          final extraPlayers =
              widget.fixtureDetails!.members
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
    return events.isNotEmpty
        ? Padding(
          padding: const EdgeInsets.all(2),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder:
                (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(20),
                    child: Column(
                      children: [
                        eventTeam(events[index], context),
                        SizedBox(height: 10.height),
                        eventDetails(events[index], context),
                      ],
                    ),
                  ),
                ),
            itemCount: widget.fixtureDetails!.sortedEvents.length,
          ),
        )
        : ItemsNotAvailable(
          message: AppStrings.noEvents,
          icon: Icons.event_busy,
          color: widget.color,
        );
  }

  Widget eventDetails(Event event, BuildContext context) => Row(
    children: [
      CircleAvatar(
        radius: 12.5.radius,
        backgroundColor: widget.color,
        child: Text(
          event.gameTimeDisplay,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 15.width),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.type.name,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (event.type.subTypeName != null)
                  Text(
                    event.type.subTypeName ?? '',
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
              ],
            ),
            SizedBox(height: 10.height),
            if (event.type.id.isGoalOrOwnGoal || event.type.id.isMissedPenalty)
              eventGoal(event, context),
            if (event.type.id.isCard) eventCard(event, context),
            if (event.type.id.isSubstitute) eventSubset(event, context),
          ],
        ),
      ),
    ],
  );

  Widget eventTeam(Event event, BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomImage(
        width: 20.radius,
        height: 20.radius,
        imageUrl: event.team?.logo ?? '',
      ),
      SizedBox(width: 10.width),
      Text(
        event.team?.name.teamName ?? '',
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: AppColors.blueGrey),
      ),
    ],
  );

  Widget eventSubset(Event event, BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.red),
        ),
      ),
      SizedBox(width: 10.width),
      Image(
        width: 30.radius,
        height: 30.radius,
        image: const AssetImage(AppAssets.subs),
      ),
      SizedBox(width: 10.width),
      Expanded(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            event.extraPlayerDetails != null &&
                    event.extraPlayerDetails!.isNotEmpty
                ? event.extraPlayerDetails!.first.name
                : '',
            textAlign: TextAlign.end,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: AppColors.green),
          ),
        ),
      ),
    ],
  );

  Widget eventCard(Event event, BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      SizedBox(width: 10.width),
      Container(
        color: event.type.id.isYellowCard ? AppColors.yellow : AppColors.red,
        width: 20.width,
        height: 25.height,
      ),
      Expanded(child: Container()),
    ],
  );

  Widget eventGoal(Event event, BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.player?.name.playerName ?? '',
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.blue),
        ),
      ),
      SizedBox(width: 10.width),
      event.type.id.isGoalOrOwnGoal
          ? Icon(Icons.sports_soccer, size: 25.radius)
          : penaltyMissed(),
      SizedBox(width: 10.width),
      if (event.extraPlayerDetails != null &&
          event.extraPlayerDetails!.isNotEmpty)
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "${AppStrings.assist}: ${event.extraPlayerDetails!.map((e) => e.name.playerName).join(', ')}",
              textAlign: TextAlign.end,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: AppColors.green),
            ),
          ),
        )
      else
        const Expanded(child: SizedBox.shrink()),
    ],
  );

  Widget penaltyMissed() => Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Icon(Icons.sports_soccer, size: 25.radius),
      CircleAvatar(
        radius: 8.radius,
        backgroundColor: AppColors.red,
        child: Icon(Icons.close, color: AppColors.white, size: 10.radius),
      ),
    ],
  );
}
