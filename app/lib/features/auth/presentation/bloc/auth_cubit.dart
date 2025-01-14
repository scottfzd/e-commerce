import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_state.dart';
import 'package:app/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call(NoParams());
    if (isLoggedIn.isRight() && isLoggedIn.getOrElse(() => true)) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
