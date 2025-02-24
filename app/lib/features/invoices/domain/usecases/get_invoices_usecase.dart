import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/invoices/data/models/get_invoices_params.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:dartz/dartz.dart';

class GetInvoicesUsecase
    implements UseCase<InvoicesPageEntity, GetInvoicesParams> {
  final InvoiceRepository invoiceRepository;
  GetInvoicesUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoicesPageEntity>> call(
      GetInvoicesParams params) async {
    return invoiceRepository.getInvoices(params.page, params.limit);
  }
}
