import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/lineups.dart';
import '../repositories/fixture_repository.dart';

class LineupsUseCase implements UseCase<List<Lineup>, String> {
  final FixtureRepository fixtureRepository;

  LineupsUseCase({required this.fixtureRepository});

  @override
  Future<Either<Failure, List<Lineup>>> call(String params) async {
    return await fixtureRepository.getLineups(params);
  }
}
