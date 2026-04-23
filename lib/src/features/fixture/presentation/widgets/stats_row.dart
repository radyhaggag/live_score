import 'package:flutter/material.dart';

import '../../domain/entities/statistics.dart';

/// A single row comparing a home stat vs away stat.
class StatsRow extends StatelessWidget {
  final Statistic home;
  final Statistic away;

  const StatsRow({super.key, required this.home, required this.away});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: Text(home.value, textAlign: TextAlign.center)),
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              home.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        Expanded(child: Text(away.value, textAlign: TextAlign.center)),
      ],
    );
  }
}
