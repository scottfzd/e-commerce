import 'package:app/core/error/failures.dart';
import 'package:app/features/invoices/data/models/invoice_detailed_model.dart';
import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/features/invoices/data/models/invoices_pagination_model.dart';
import 'package:app/features/invoices/data/services/invoice_remote_service.dart';
import 'package:app/features/invoices/domain/entities/invoice_detailed_entity.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<Either<Failure, InvoicesPaginationEntity>> getInvoices(
      int page, int limit) async {
    Either result = await sl<InvoiceRemoteService>().getInvoices(page, limit);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(InvoicesPaginationModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, InvoicesPaginationEntity>> getInvoicesByUserId(
      int userId, int page, int limit) async {
    Either result = await sl<InvoiceRemoteService>()
        .getInvoicesByUserId(userId, page, limit);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(InvoicesPaginationModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, InvoiceDetailedEntity>> getInvoiceById(int id) async {
    Either result = await sl<InvoiceRemoteService>().getInvoiceById(id);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(InvoiceDetailedModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoice) async {
    Either result = await sl<InvoiceRemoteService>()
        .createInvoice(InvoiceModel.fromEntity(invoice));
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(InvoiceModel.fromJson(response.data).toEntity());
    });
  }
}
