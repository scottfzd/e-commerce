import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:dartz/dartz.dart';

class GetInvoiceByIdUsecase implements UseCase<InvoiceEntity, int> {
  final InvoiceRepository invoiceRepository;
  GetInvoiceByIdUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoiceEntity>> call(int id) async {
    return invoiceRepository.getInvoiceById(id);
  }
}
