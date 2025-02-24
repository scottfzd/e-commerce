import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/invoices/data/models/get_invoices_by_user_id_params.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:dartz/dartz.dart';

class GetInvoicesByUserIdUsecase
    implements UseCase<InvoicesPageEntity, GetInvoicesByUserIdParams> {
  final InvoiceRepository invoiceRepository;
  GetInvoicesByUserIdUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoicesPageEntity>> call(
      GetInvoicesByUserIdParams params) async {
    return invoiceRepository.getInvoicesByUserId(
        params.userId, params.page, params.limit);
  }
}
