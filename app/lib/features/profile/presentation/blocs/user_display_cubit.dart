import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:app/features/profile/presentation/blocs/user_display_state.dart';
import 'package:app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await sl<GetUserUsecase>().call(NoParams());
    result.fold((error) {
      emit(LoadUserFailure(errorMessage: error.toString()));
    }, (data) {
      emit(UserLoaded(userEntity: data));
    });
  }
}
