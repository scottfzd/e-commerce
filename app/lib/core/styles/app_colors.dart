import 'package:app/core/styles/themes/color_scheme.dart';
import 'package:app/core/styles/themes/system_ui_overlay_style.dart';
import 'package:app/core/styles/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  final ColorScheme colorScheme;
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final TextTheme textTheme;

  AppColors({
    required this.colorScheme,
    required this.systemUiOverlayStyle,
    required this.textTheme,
  });

  static final lightColors = AppColors(
    colorScheme: lightColorScheme,
    systemUiOverlayStyle: lightSystemUiOverlayStyle,
    textTheme: lightTextTheme,
  );

  static final darkColors = AppColors(
    colorScheme: darkColorScheme,
    systemUiOverlayStyle: darkSystemUiOverlayStyle,
    textTheme: darkTextTheme,
  );
}
