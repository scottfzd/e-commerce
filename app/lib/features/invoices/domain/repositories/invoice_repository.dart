import 'package:app/core/error/failures.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:dartz/dartz.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, InvoicesPageEntity>> getInvoices(int page, int limit);
  Future<Either<Failure, InvoicesPageEntity>> getInvoicesByUserId(
      int userId, int page, int limit);
  Future<Either<Failure, InvoiceEntity>> getInvoiceById(int id);
  Future<Either<Failure, InvoiceEntity>> createInvoice(InvoiceEntity invoice);
}
