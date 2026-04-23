import 'package:dartz/dartz.dart';

import '../error/error_handler.dart';

/// Represents the use case entity/model.
abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

/// Represents the no params entity/model.
class NoParams {
  const NoParams._internal();

  static const NoParams _instance = NoParams._internal();

  factory NoParams() => _instance;
}
