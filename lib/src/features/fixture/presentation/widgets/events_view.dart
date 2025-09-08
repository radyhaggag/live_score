import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:live_score/src/core/extensions/nums.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/events.dart';
import 'items_not_available.dart';

class EventsView extends StatelessWidget {
  final List<Event> events;
  final Color color;

  const EventsView({super.key, required this.events, required this.color});

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
            itemCount: events.length,
          ),
        )
        : const ItemsNotAvailable(
          message: AppStrings.noEvents,
          icon: Icons.event_busy,
        );
  }

  Widget eventDetails(Event event, BuildContext context) => Row(
    children: [
      CircleAvatar(
        radius: 15.radius,
        backgroundColor: color,
        child: Text(
          event.time.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      SizedBox(width: 10.width),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.type,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(event.detail, textAlign: TextAlign.end),
              ],
            ),
            const SizedBox(height: 10),
            if (event.type == AppStrings.goal) eventGoal(event, context),
            if (event.type == AppStrings.card) eventCard(event, context),
            if (event.type == AppStrings.subst) eventSubset(event, context),
          ],
        ),
      ),
    ],
  );

  Widget eventTeam(Event event, BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CachedNetworkImage(
        width: 20.radius,
        height: 20.radius,
        imageUrl: event.team.logo,
      ),
      SizedBox(width: 10.width),
      Text(
        event.team.name,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.blueGrey),
      ),
    ],
  );

  Widget eventSubset(Event event, BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          event.assistName,
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
        ),
      ),
      Image(
        width: 40.radius,
        height: 40.radius,
        image: AssetImage(AppAssets.subs),
      ),
      Expanded(
        child: Text(
          event.playerName,
          textAlign: TextAlign.end,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.green),
        ),
      ),
    ],
  );

  Widget eventCard(Event event, BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.playerName,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      Container(
        color:
            event.detail == AppStrings.yellowCard
                ? AppColors.yellow
                : AppColors.red,
        width: 20.radius,
        height: 30.radius,
      ),
      Expanded(child: Container()),
    ],
  );

  Widget eventGoal(Event event, BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          event.playerName,
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.blue),
        ),
      ),
      event.detail != AppStrings.missedPenalty
          ? Icon(Icons.sports_soccer, size: 30.radius)
          : penaltyMissed(),
      Expanded(
        child: Text(
          "${AppStrings.assist}: ${event.assistName.split(" ").last}",
          textAlign: TextAlign.end,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.red),
        ),
      ),
    ],
  );

  Widget penaltyMissed() => Stack(
    alignment: AlignmentDirectional.bottomEnd,
    children: [
      Icon(Icons.sports_soccer, size: 30.radius),
      CircleAvatar(
        radius: 8.radius,
        backgroundColor: AppColors.red,
        child: Icon(Icons.close, color: AppColors.white, size: 10.radius),
      ),
    ],
  );
}
