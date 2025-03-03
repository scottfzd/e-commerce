import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_state.dart';
import 'package:app/features/auth/presentation/pages/login_page.dart';
import 'package:app/main.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
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

  void logout() async {
    await sl<LogoutUsecase>().call(NoParams());
    debugPrint(navigatorKey.currentState.toString());
    await navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
