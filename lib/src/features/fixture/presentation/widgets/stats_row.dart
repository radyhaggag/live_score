import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extensions/context_ext.dart';
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

    // Determine winner for color coding
    final bool homeWins = homeVal > awayVal;
    final bool awayWins = awayVal > homeVal;

    final homeColor = homeWins ? context.colors.primary : context.colorsExt.textMuted.withValues(alpha: 0.3);
    final awayColor = awayWins ? context.colors.primary : context.colorsExt.textMuted.withValues(alpha: 0.3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  home.value, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: homeWins ? context.colors.primary : null,
                  ), 
                  textAlign: TextAlign.start
                ),
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    home.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: context.colorsExt.textSubtle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text(
                  away.value, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: awayWins ? context.colors.primary : null,
                  ), 
                  textAlign: TextAlign.end
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              // 4px gap between the two bars
              final availableWidth = maxWidth - 4;
              final homeWidth = (availableWidth * homeFlex).clamp(0.0, availableWidth);
              final awayWidth = (availableWidth * awayFlex).clamp(0.0, availableWidth);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Home Bar
                  Container(
                    width: homeWidth,
                    height: 8,
                    decoration: BoxDecoration(
                      color: homeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate().scaleX(begin: 0, alignment: Alignment.centerRight, duration: 600.ms, curve: Curves.easeOutCubic),
                  const SizedBox(width: 4),
                  // Away Bar
                  Container(
                    width: awayWidth,
                    height: 8,
                    decoration: BoxDecoration(
                      color: awayColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate().scaleX(begin: 0, alignment: Alignment.centerLeft, duration: 600.ms, curve: Curves.easeOutCubic),
                ],
              );
            }
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
