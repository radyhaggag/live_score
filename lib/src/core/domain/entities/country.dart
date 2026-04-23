import 'package:equatable/equatable.dart';

/// Represents the country entity/model.
class Country extends Equatable {
  final int id;
  final String name;

  const Country({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
