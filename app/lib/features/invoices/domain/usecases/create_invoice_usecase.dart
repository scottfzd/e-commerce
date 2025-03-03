import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:dartz/dartz.dart';

class CreateInvoiceUsecase implements UseCase<InvoiceEntity, InvoiceEntity> {
  final InvoiceRepository invoiceRepository;
  CreateInvoiceUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoiceEntity>> call(InvoiceEntity invoice) async {
    return invoiceRepository.createInvoice(invoice);
  }
}
