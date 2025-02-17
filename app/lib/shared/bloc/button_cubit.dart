import 'package:app/core/usecase/usecase.dart';
import 'package:app/shared/bloc/button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void execute<T>({required UseCase usecase, required T params}) async {
    emit(ButtonLoading());

    try {
      final result = await usecase.call(params);

      result.fold(
        (error) => emit(ButtonFailure(errorMessage: error.toString())),
        (data) => emit(ButtonSuccess()),
      );
    } catch (e) {
      emit(ButtonFailure(errorMessage: e.toString()));
    }
  }
}
