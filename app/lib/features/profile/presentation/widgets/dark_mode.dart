import 'package:app/features/theme/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget darkMode(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Dark Mode'),
      const SizedBox(width: 10),
      Switch(
        value: context.read<ThemeCubit>().state.themeMode == ThemeMode.dark,
        onChanged: (value) {
          context.read<ThemeCubit>().switchTheme();
        },
      ),
    ],
  );
}
