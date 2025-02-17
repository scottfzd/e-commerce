import 'package:app/core/styles/themes/color_scheme.dart';
import 'package:flutter/services.dart';

final lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: lightColorScheme.surface,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: lightColorScheme.primary,
  statusBarIconBrightness: Brightness.light,
);
final darkSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: darkColorScheme.surface,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarColor: darkColorScheme.primary,
  statusBarIconBrightness: Brightness.light,
);
