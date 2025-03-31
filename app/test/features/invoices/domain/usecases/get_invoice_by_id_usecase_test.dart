
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/usecases/get_invoice_by_id_usecase.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_invoices_by_user_id_usecase_test.mocks.dart';

@GenerateMocks([InvoiceRepository])
void main() {

  late GetInvoiceByIdUsecase getInvoiceByIdUsecase;
  late MockInvoiceRepository mockInvoiceRepository;

  
  setUp(() {

    mockInvoiceRepository = MockInvoiceRepository();
    getInvoiceByIdUsecase = GetInvoiceByIdUsecase(invoiceRepository: mockInvoiceRepository);
  });

  const invoiceId = 10;
  InvoiceEntity invoice = const InvoiceEntity();

  test('should return invoice entity by id', () async {

    when(mockInvoiceRepository.getInvoiceById(invoiceId)).thenAnswer((_) async => Right(invoice));

    final result = await getInvoiceByIdUsecase(invoiceId);

    // assert
    expect(result, equals(Right(invoice)));
    verify(mockInvoiceRepository.getInvoiceById(invoiceId)).called(1);

  });

}
