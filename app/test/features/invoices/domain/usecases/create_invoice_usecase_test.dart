

import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/usecases/create_invoice_usecase.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_invoices_by_user_id_usecase_test.mocks.dart';

@GenerateMocks([InvoiceRepository])
void main() {

  late CreateInvoiceUsecase createInvoiceUsecase;
  late MockInvoiceRepository mockInvoiceRepository;

  
  setUp(() {

    mockInvoiceRepository = MockInvoiceRepository();
    createInvoiceUsecase = CreateInvoiceUsecase(invoiceRepository: mockInvoiceRepository);
  });

  InvoiceEntity invoice = const InvoiceEntity(
    id: 2,
    userId: 2,
    cartId: 14,
    shopId: 13,
    total: 100.10,
  );

  test('should return created invoice', () async {

    when(mockInvoiceRepository.createInvoice(invoice)).thenAnswer((_) async => Right(invoice));

    final result = await createInvoiceUsecase(invoice);

    // assert
    expect(result, equals(Right(invoice)));
    verify(mockInvoiceRepository.createInvoice(invoice)).called(1);

  });

}
