import 'package:app/core/styles/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: lightColorScheme.surface,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
);
final darkSystemUiOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: darkColorScheme.surface,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
);
