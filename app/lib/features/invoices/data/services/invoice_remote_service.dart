import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class InvoiceRemoteService {
  Future<Either<Failure, Response>> getInvoices(int page, int limit);
  Future<Either<Failure, Response>> getInvoicesByUserId(
      int userId, int page, int limit);
  Future<Either<Failure, Response>> getInvoiceById(int id);
  Future<Either<Failure, Response>> createInvoice(InvoiceModel invoice);
}

class InvoiceRemoteServiceImpl extends InvoiceRemoteService {
  @override
  Future<Either<Failure, Response>> getInvoices(int page, int limit) async {
    try {
      final response = await sl<DioClient>().get(
        '${Constants.invoiceURL}/myInvoices',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ServerFailure(response.data, response.statusCode));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data, e.response?.statusCode));
    }
  }

  @override
  Future<Either<Failure, Response>> getInvoicesByUserId(
      int userId, int page, int limit) async {
    try {
      final response = await sl<DioClient>().get(
        '${Constants.userURL}/$userId/invoices',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return Left(ServerFailure(response.data, response.statusCode));
      }
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> getInvoiceById(int id) async {
    try {
      final response = await sl<DioClient>().get(
        '${Constants.invoiceURL}/$id',
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> createInvoice(InvoiceModel invoice) async {
    try {
      final response = await sl<DioClient>().post(
        Constants.invoiceURL,
        data: invoice.toJson(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }
}
