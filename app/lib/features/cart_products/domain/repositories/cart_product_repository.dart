import 'package:app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class CartProductRepository {
  Future<Either<Failure, Response>> removeProductFromCart(int cartProductId);
}