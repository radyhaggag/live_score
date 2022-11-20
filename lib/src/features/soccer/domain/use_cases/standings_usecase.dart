import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/standings.dart';
import '../repositories/soccer_repository.dart';

class StandingsUseCase extends UseCase<Standings, StandingsParams> {
  final SoccerRepository soccerRepository;

  StandingsUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, Standings>> call(StandingsParams params) async {
    return await soccerRepository.getStandings(params: params);
  }
}

class StandingsParams extends Equatable {
  final String leagueId;
  final String season;

  const StandingsParams({required this.leagueId, required this.season});

  @override
  List<Object?> get props => [leagueId, season];

  Map<String, dynamic> toJson() => {"league": leagueId, "season": season};
}
