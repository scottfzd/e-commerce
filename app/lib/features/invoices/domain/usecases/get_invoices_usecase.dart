import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:app/shared/models/pagination_params_model.dart';
import 'package:dartz/dartz.dart';

class GetInvoicesUsecase
    implements UseCase<InvoicesPaginationEntity, PaginationParams> {
  final InvoiceRepository invoiceRepository;
  GetInvoicesUsecase({required this.invoiceRepository});

  @override
  Future<Either<Failure, InvoicesPaginationEntity>> call(
      PaginationParams pagination) async {
    return invoiceRepository.getInvoices(pagination.page, pagination.limit);
  }
}
