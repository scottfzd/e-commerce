import 'package:app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Interface pour les UseCases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Type utilisé pour les UseCases sans paramètres
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
