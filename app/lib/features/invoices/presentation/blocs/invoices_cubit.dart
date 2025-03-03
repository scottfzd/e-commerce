import 'package:app/features/invoices/domain/entities/invoice_entity.dart';
import 'package:app/features/invoices/domain/entities/invoices_pagination_entity.dart';
import 'package:app/features/invoices/domain/usecases/get_invoices_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:app/shared/models/pagination_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failures.dart';
import 'package:flutter/material.dart';
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

    final Either<Failure, InvoicesPaginationEntity> result =
        await sl<GetInvoicesUsecase>()
            .call(PaginationParams(page: page, limit: limit));

    result.fold(
      (failure) {
        emit(InvoicesError(_mapFailureToMessage(failure)));
      },
      (invoicesPagination) {
        _currentPage = invoicesPagination.pagination!.currentPage!;
        _totalPages = invoicesPagination.pagination!.totalPages!;
        debugPrint(_currentPage.toString());
        debugPrint(_totalPages.toString());
        if (page == 1) {
          _allInvoices = invoicesPagination.invoices;
        } else {
          _allInvoices.addAll(invoicesPagination.invoices);
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
