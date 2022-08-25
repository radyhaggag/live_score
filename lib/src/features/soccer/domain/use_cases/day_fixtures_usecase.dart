import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/soccer_repository.dart';

class DayFixturesUseCase implements UseCase<List<SoccerFixture>, String> {
  final SoccerRepository soccerRepository;

  DayFixturesUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, List<SoccerFixture>>> call(String date) async {
    return await soccerRepository.getDayFixtures(date: date);
  }
}
