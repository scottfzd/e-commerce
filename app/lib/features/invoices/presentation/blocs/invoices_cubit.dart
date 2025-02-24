import 'package:app/features/invoices/data/models/get_invoices_params.dart';
import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:app/features/invoices/domain/entities/invoices_page_entity.dart';
import 'package:app/core/error/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  InvoicesCubit() : super(InvoicesLoading());

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetching = false;
  List<InvoiceEntity> _allInvoices = [];

  Future<void> fetchInvoices({int page = 1, int limit = 10}) async {
    if (_isFetching || page > _totalPages) return;

    _isFetching = true;
    if (page == 1) {
      emit(InvoicesLoading());
    } else {
      emit(InvoicesLoadingMore(_allInvoices));
    }

    final Either<Failure, InvoicesPageEntity> result =
        await sl<GetInvoicesUsecase>()
            .call(GetInvoicesParams(page: page, limit: limit));

    result.fold(
      (failure) {
        emit(InvoicesError(_mapFailureToMessage(failure)));
      },
      (invoicesPage) {
        _currentPage = invoicesPage.currentPage;
        _totalPages = invoicesPage.totalPages;
        if (page == 1) {
          _allInvoices = invoicesPage.invoices;
        } else {
          _allInvoices.addAll(invoicesPage.invoices);
        }
        emit(InvoicesLoaded(_allInvoices));
      },
    );

    _isFetching = false;
  }

  void loadNextPage() {
    if (_currentPage < _totalPages) {
      fetchInvoices(page: _currentPage + 1);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Erreur serveur. Veuillez réessayer plus tard.';
    } else if (failure is TimeoutFailure) {
      return 'Vérifiez votre connexion Internet.';
    } else {
      return 'Une erreur inconnue est survenue.';
    }
  }
}
