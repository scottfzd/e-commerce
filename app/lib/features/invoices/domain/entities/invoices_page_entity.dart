import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

class InvoicesPageEntity {
  final List<InvoiceEntity> invoices;
  final int currentPage;
  final int totalPages;
  final int totalInvoices;
  final int perPage;

  InvoicesPageEntity({
    required this.invoices,
    required this.currentPage,
    required this.totalPages,
    required this.totalInvoices,
    required this.perPage,
  });
}
