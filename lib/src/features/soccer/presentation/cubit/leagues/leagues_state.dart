import 'package:flutter/foundation.dart';

import '../../../../../core/domain/entities/league.dart';

@immutable
sealed class LeaguesState {}

/// Represents the leagues initial entity/model.
class LeaguesInitial extends LeaguesState {}

/// Represents the leagues loading entity/model.
class LeaguesLoading extends LeaguesState {}

/// Represents the leagues loaded entity/model.
class LeaguesLoaded extends LeaguesState {
  final List<League> leagues;

  LeaguesLoaded(this.leagues);
}

/// Represents the leagues load failure entity/model.
class LeaguesLoadFailure extends LeaguesState {
  final String message;

  LeaguesLoadFailure(this.message);
}
