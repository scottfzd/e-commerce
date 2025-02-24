import 'package:app/core/error/failures.dart';
import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/features/invoices/data/services/invoice_remote_service.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<Either<Failure, InvoicesPageEntity>> getInvoices(
      int page, int limit) async {
    Either result = await sl<InvoiceRemoteService>().getInvoices(page, limit);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, InvoicesPageEntity>> getInvoicesByUserId(
      int userId, int page, int limit) async {
    Either result = await sl<InvoiceRemoteService>()
        .getInvoicesByUserId(userId, page, limit);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id) async {
    Either result = await sl<InvoiceRemoteService>().getInvoiceById(id);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
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
      return Right(data);
    });
  }
}
