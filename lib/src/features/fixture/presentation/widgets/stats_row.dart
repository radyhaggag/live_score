import 'package:flutter/material.dart';

import '../../domain/entities/statistics.dart';

/// A single row comparing a home stat vs away stat.
class StatsRow extends StatelessWidget {
  final Statistic home;
  final Statistic away;

  const StatsRow({super.key, required this.home, required this.away});

  @override
  Widget build(BuildContext context) {
    final double homeVal = _parseValue(home.value);
    final double awayVal = _parseValue(away.value);
    final double total = homeVal + awayVal;
    
    final double homeFlex = total > 0 ? homeVal / total : 0.5;
    final double awayFlex = total > 0 ? awayVal / total : 0.5;

    // Prevent flex from being exactly 0 which causes rendering issues
    final int hFlex = (homeFlex * 1000).toInt().clamp(1, 1000);
    final int aFlex = (awayFlex * 1000).toInt().clamp(1, 1000);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: Text(home.value, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.start),
              ),
              Expanded(
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
              SizedBox(
                width: 40,
                child: Text(away.value, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.end),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: hFlex,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                flex: aFlex,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(3),
                      bottomRight: Radius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _parseValue(String val) {
    final cleanVal = val.replaceAll('%', '').trim();
    return double.tryParse(cleanVal) ?? 0.0;
  }
}
