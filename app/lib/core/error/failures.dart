import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

/// General failures
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.errorMessage, this.statusCode);
}

/// Cancel token failure
class TimeoutFailure extends Failure {
  final int? statusCode;

  const TimeoutFailure(super.errorMessage, this.statusCode);
}
