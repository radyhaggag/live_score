import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/statistics.dart';
import '../repositories/fixture_repository.dart';

class StatisticsUseCase implements UseCase<Statistics, int> {
  final FixtureRepository fixtureRepository;

  StatisticsUseCase({required this.fixtureRepository});

  @override
  Future<Either<Failure, Statistics>> call(int params) async {
    return await fixtureRepository.getStatistics(params);
  }
}
