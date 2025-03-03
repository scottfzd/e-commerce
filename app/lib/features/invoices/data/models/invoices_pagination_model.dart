import 'package:app/features/invoices/data/models/invoice_model.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:app/shared/models/pagination_model.dart';

class InvoicesPaginationModel extends InvoicesPaginationEntity {
  InvoicesPaginationModel({
    required super.invoices,
    super.pagination,
  });

  factory InvoicesPaginationModel.fromJson(Map<String, dynamic> json) {
    return InvoicesPaginationModel(
      invoices: (json['invoices'] as List<dynamic>?)
              ?.map((invoiceJson) => InvoiceModel.fromJson(invoiceJson))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invoices': invoices,
      'pagination': pagination,
    };
  }

  factory InvoicesPaginationModel.fromEntity(InvoicesPaginationEntity entity) {
    return InvoicesPaginationModel(
      invoices: entity.invoices,
      pagination: entity.pagination,
    );
  }

  InvoicesPaginationEntity toEntity() {
    return InvoicesPaginationEntity(
      invoices: invoices,
      pagination: pagination,
    );
  }
}
