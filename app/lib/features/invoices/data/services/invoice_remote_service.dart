import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class InvoiceRemoteService {
  Future<Either<Failure, InvoicesPageEntity>> getInvoices(int page, int limit);
  Future<Either<Failure, InvoicesPageEntity>> getInvoicesByUserId(
      int userId, int page, int limit);
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id);
  Future<Either<Failure, InvoiceEntity>> createInvoice(InvoiceModel invoice);
}

class InvoiceRemoteServiceImpl extends InvoiceRemoteService {
  @override
  Future<Either<Failure, InvoicesPageEntity>> getInvoices(
      int page, int limit) async {
    try {
      final response = await sl<DioClient>().get(
        '${Constants.userURL}/me/invoices',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<InvoiceEntity> invoices = (data['invoices'] as List)
            .map((json) => InvoiceModel.fromJson(json))
            .toList();

        return Right(InvoicesPageEntity(
          invoices: invoices,
          currentPage: data['pagination']['current_page'],
          totalPages: data['pagination']['total_pages'],
          totalInvoices: data['pagination']['total_invoices'],
          perPage: data['pagination']['per_page'],
        ));
      } else {
        return Left(ServerFailure(response.data, response.statusCode));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data, e.response?.statusCode));
    }
  }

  @override
  Future<Either<Failure, InvoicesPageEntity>> getInvoicesByUserId(
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
        final data = response.data;
        final List<InvoiceEntity> invoices = (data['invoices'] as List)
            .map((json) => InvoiceModel.fromJson(json))
            .toList();

        return Right(InvoicesPageEntity(
          invoices: invoices,
          currentPage: data['pagination']['current_page'],
          totalPages: data['pagination']['total_pages'],
          totalInvoices: data['pagination']['total_invoices'],
          perPage: data['pagination']['per_page'],
        ));
      } else {
        return Left(ServerFailure(response.data, response.statusCode));
      }
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id) async {
    try {
      final response = await sl<DioClient>().get(
        '${Constants.invoiceURL}/$id',
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceModel invoice) async {
    try {
      final response = await sl<DioClient>().post(
        Constants.invoiceURL,
        data: invoice.toJson(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }
}
