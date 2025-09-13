import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/teams.dart';

class Statistics extends Equatable {
  final Teams? teams;
  final List<Statistic>? statistics;

  const Statistics({required this.teams, required this.statistics});

  List<Statistic>? get homeStatistics {
    final stats =
        statistics
            ?.where((stat) => stat.competitorId == teams?.home.id)
            .toList();
    stats?.sort((a, b) => a.order.compareTo(b.order));
    return stats;
  }

  List<Statistic>? get awayStatistics {
    final stats =
        statistics
            ?.where((stat) => stat.competitorId == teams?.away.id)
            .toList();
    stats?.sort((a, b) => a.order.compareTo(b.order));
    return stats;
  }

  @override
  List<Object?> get props => [teams, statistics];
}

class Statistic extends Equatable {
  final int id;
  final int competitorId;
  final String name;
  final String value;
  final num valuePercentage;
  final int order;
  final int? categoryId;
  final String? categoryName;
  final bool isTop;

  const Statistic({
    required this.id,
    required this.competitorId,
    required this.name,
    required this.value,
    required this.valuePercentage,
    required this.order,
    this.categoryId,
    this.categoryName,
    this.isTop = false,
  });

  @override
  List<Object?> get props => [
    id,
    competitorId,
    name,
    value,
    valuePercentage,
    order,
  ];
}
