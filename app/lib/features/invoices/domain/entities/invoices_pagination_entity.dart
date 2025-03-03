import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/shared/entities/pagination_entity.dart';

class InvoicesPaginationEntity {
  final List<InvoiceEntity> invoices;
  final PaginationEntity? pagination;

  InvoicesPaginationEntity({
    required this.invoices,
    this.pagination,
  });
}
