import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/soccer_repository.dart';

class CurrentRoundFixturesUseCase implements UseCase<List<SoccerFixture>, int> {
  final SoccerRepository soccerRepository;

  CurrentRoundFixturesUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, List<SoccerFixture>>> call(int competitionId) async {
    return await soccerRepository.getCurrentRoundFixtures(
      competitionId: competitionId,
    );
  }
}
