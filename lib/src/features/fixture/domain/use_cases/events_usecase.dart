import 'package:dartz/dartz.dart';
import '../entities/events.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/fixture_repository.dart';

class EventsUseCase implements UseCase<List<Event>, String> {
  final FixtureRepository fixtureRepository;

  EventsUseCase({required this.fixtureRepository});

  @override
  Future<Either<Failure, List<Event>>> call(String params) async {
    return await fixtureRepository.getEvents(params);
  }
}
