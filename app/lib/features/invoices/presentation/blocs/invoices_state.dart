import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

abstract class InvoicesState {}

class InvoicesLoading extends InvoicesState {}

class InvoicesLoadingMore extends InvoicesState {
  final List<InvoiceEntity> invoices;
  InvoicesLoadingMore(this.invoices);
}

class InvoicesLoaded extends InvoicesState {
  final List<InvoiceEntity> invoices;

  InvoicesLoaded(this.invoices);
}

class InvoicesError extends InvoicesState {
  final String message;

  InvoicesError(this.message);
}
