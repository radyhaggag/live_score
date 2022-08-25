import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/soccer_repository.dart';

class LiveFixturesUseCase implements UseCase<List<SoccerFixture>, NoParams> {
  final SoccerRepository soccerRepository;

  LiveFixturesUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, List<SoccerFixture>>> call(NoParams params) async {
    return await soccerRepository.getLiveFixtures();
  }
}
