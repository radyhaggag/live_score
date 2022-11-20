import 'package:dartz/dartz.dart';

import '../error/error_handler.dart';

abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

class NoParams {
  const NoParams._internal();

  static const NoParams _instance = NoParams._internal();

  factory NoParams() => _instance;
}
