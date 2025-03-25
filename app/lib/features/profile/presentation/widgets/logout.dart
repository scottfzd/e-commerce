import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:app/shared/bloc/button_cubit.dart';
import 'package:app/shared/widgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget logout(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      BasicButton(
        title: 'Logout',
        onPressed: () {
          context.read<ButtonCubit>().execute(
                usecase: LogoutUsecase(authRepository: sl<AuthRepository>()),
                params: null,
              );
        },
        width: 200,
      ),
    ],
  );
}
