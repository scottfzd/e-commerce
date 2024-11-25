import 'package:app/shared/bloc/button_cubit.dart';
import 'package:app/shared/bloc/button_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  const BasicButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoading) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
        ));
  }

  Widget _initial(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize:
            Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
      ),
      child: Text(
        title,
      ),
    );
  }
}
