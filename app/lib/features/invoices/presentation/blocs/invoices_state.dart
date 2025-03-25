import 'package:app/features/invoices/domain/entities/invoice_detailed_entity.dart';
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

class InvoiceDetailedLoading extends InvoicesState {}

class InvoiceDetailedLoaded extends InvoicesState {
  final InvoiceDetailedEntity invoice;

  InvoiceDetailedLoaded(this.invoice);
}

class InvoiceDetailedError extends InvoicesState {
  final String message;

  InvoiceDetailedError(this.message);
}
