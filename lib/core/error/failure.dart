import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  final String? message;
  const ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String? message;
  const CacheFailure({this.message});

  @override
  List<Object?> get props => [message];
}
