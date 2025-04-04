import 'package:app/core/error/failures.dart';
import 'package:app/features/invoices/domain/entities/invoice_detailed_entity.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:dartz/dartz.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, InvoicesPaginationEntity>> getInvoices(
      int page, int limit);
  Future<Either<Failure, InvoicesPaginationEntity>> getInvoicesByUserId(
      int userId, int page, int limit);
  Future<Either<Failure, InvoiceDetailedEntity>> getInvoiceById(int id);
  Future<Either<Failure, InvoiceEntity>> createInvoice(InvoiceEntity invoice);
}
