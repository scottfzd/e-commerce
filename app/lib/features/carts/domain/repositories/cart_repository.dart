import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>>getMyCart(shopId);
}