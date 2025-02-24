import 'package:app/features/invoices/data/repositories/invoice_repository_impl.dart';
import 'package:app/features/invoices/data/services/invoice_remote_service.dart';
import 'package:app/features/invoices/domain/repositories/invoice_repository.dart';
import 'package:app/features/invoices/domain/usecases/create_invoice_usecase.dart';
import 'package:app/features/invoices/domain/usecases/get_invoice_by_id_usecase.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices_by_user_id_usecase.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupInvoiceServiceLocator() {
  // Services
  sl.registerLazySingleton<InvoiceRemoteService>(
      () => InvoiceRemoteServiceImpl());

  // Repositories
  sl.registerLazySingleton<InvoiceRepository>(() => InvoiceRepositoryImpl());

  // Usecases
  sl.registerFactory(
      () => GetInvoicesUsecase(invoiceRepository: sl<InvoiceRepository>()));
  sl.registerFactory(() =>
      GetInvoicesByUserIdUsecase(invoiceRepository: sl<InvoiceRepository>()));
  sl.registerFactory(
      () => GetInvoiceByIdUsecase(invoiceRepository: sl<InvoiceRepository>()));
  sl.registerFactory(
      () => CreateInvoiceUsecase(invoiceRepository: sl<InvoiceRepository>()));
}
