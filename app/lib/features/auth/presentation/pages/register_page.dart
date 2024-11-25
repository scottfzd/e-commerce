import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/domain/usecases/register_usecase.dart';
import 'package:app/features/auth/presentation/pages/login_page.dart';
import 'package:app/shared/bloc/button_cubit.dart';
import 'package:app/shared/bloc/button_state.dart';
import 'package:app/shared/widgets/basic_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();
  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ButtonCubit(),
          child: BlocListener<ButtonCubit, ButtonState>(
            listener: (context, state) {},
            child: SafeArea(
              child: _registerForm(context),
            ),
          )),
    );
  }

  Widget _registerForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _emailCon,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordCon,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordCon,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
            obscureText: true,
          ),
          TextField(
            controller: _firstNameCon,
            decoration: const InputDecoration(
              labelText: 'First Name',
            ),
          ),
          TextField(
            controller: _lastNameCon,
            decoration: const InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (context) {
              return BasicButton(
                title: 'Register',
                onPressed: () {
                  context.read<ButtonCubit>().execute(
                        usecase: RegisterUsecase(),
                        params: RegisterParams(
                          email: _emailCon.text,
                          password: _passwordCon.text,
                          passwordConfirmation: _confirmPasswordCon.text,
                          firstName: _firstNameCon.text,
                          lastName: _lastNameCon.text,
                        ),
                      );
                },
              );
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text('Already have an account? Login here!'),
          ),
        ],
      ),
    );
  }
}
