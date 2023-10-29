import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_values.dart';
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
            padding: const EdgeInsets.all(AppPadding.p2),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(AppPadding.p20),
                  child: Column(
                    children: [
                      eventTeam(events[index], context),
                      const SizedBox(height: AppSize.s10),
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
            radius: AppSize.s15,
            backgroundColor: color,
            child: Text(
              event.time.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: AppSize.s10),
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
                if (event.type == AppStrings.subst) eventSubset(event, context)
              ],
            ),
          ),
        ],
      );

  Widget eventTeam(Event event, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: AppSize.s20,
            height: AppSize.s20,
            image: NetworkImage(event.team.logo),
          ),
          const SizedBox(width: AppSize.s10),
          Text(
            event.team.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.blueGrey),
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
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.red),
            ),
          ),
          const Image(
            width: AppSize.s40,
            height: AppSize.s40,
            image: AssetImage(AppAssets.subs),
          ),
          Expanded(
            child: Text(
              event.playerName,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.green),
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
            color: event.detail == AppStrings.yellowCard
                ? AppColors.yellow
                : AppColors.red,
            width: AppSize.s20,
            height: AppSize.s30,
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
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.blue),
            ),
          ),
          event.detail != AppStrings.missedPenalty
              ? const Icon(Icons.sports_soccer, size: AppSize.s30)
              : penaltyMissed(),
          Expanded(
            child: Text(
              "${AppStrings.assist}: ${event.assistName.split(" ").last}",
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.red),
            ),
          ),
        ],
      );

  Widget penaltyMissed() => const Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Icon(Icons.sports_soccer, size: AppSize.s30),
          CircleAvatar(
            radius: AppSize.s8,
            backgroundColor: AppColors.red,
            child: Icon(Icons.close, color: AppColors.white, size: AppSize.s10),
          ),
        ],
      );
}
