import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/league.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/soccer_repository.dart';

class LeaguesUseCase implements UseCase<List<League>, NoParams> {
  final SoccerRepository soccerRepository;

  LeaguesUseCase({required this.soccerRepository});

  @override
  Future<Either<Failure, List<League>>> call(NoParams params) async {
    return await soccerRepository.getLeagues();
  }
}
