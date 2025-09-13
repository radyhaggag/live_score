import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/fixture_details.dart';
import '../repositories/fixture_repository.dart';

class FixtureDetailsUseCase implements UseCase<FixtureDetails, int> {
  final FixtureRepository fixtureRepository;

  FixtureDetailsUseCase({required this.fixtureRepository});

  @override
  Future<Either<Failure, FixtureDetails>> call(int params) async {
    return await fixtureRepository.getFixtureDetails(params);
  }
}
