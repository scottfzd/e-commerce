import 'package:app/features/invoices/data/models/get_invoices_by_user_id_params.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices_by_user_id_usecase.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_invoices_by_user_id_usecase_test.mocks.dart';

@GenerateMocks([InvoiceRepository])
void main() {

  late GetInvoicesByUserIdUsecase getInvoicesByUserIdUsecase;
  late MockInvoiceRepository mockInvoiceRepository;

  
  setUp(() {

    mockInvoiceRepository = MockInvoiceRepository();
    getInvoicesByUserIdUsecase = GetInvoicesByUserIdUsecase(invoiceRepository: mockInvoiceRepository);
  });


  const userId = 1;


  List<InvoiceEntity> invoicesList = [
    const InvoiceEntity(),
    const InvoiceEntity(),
  ];

  InvoicesPaginationEntity invoices = InvoicesPaginationEntity(invoices: invoicesList);

  GetInvoicesByUserIdParams params = const GetInvoicesByUserIdParams(userId: userId, page: 1, limit: 10);

  test('should get products by shop id', () async {

    when(mockInvoiceRepository.getInvoicesByUserId(params.userId, params.page, params.limit)).thenAnswer((_) async => Right(invoices));

    final result = await getInvoicesByUserIdUsecase(params);

    // assert
    expect(result, equals(Right(invoices)));
    verify(mockInvoiceRepository.getInvoicesByUserId(params.userId, params.page, params.limit)).called(1);

  });

}
