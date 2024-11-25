import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue,
  onPrimary: Colors.white,
  secondary: Colors.lightBlueAccent,
  onSecondary: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blueGrey,
  onPrimary: Colors.black,
  secondary: Colors.blueAccent,
  onSecondary: Colors.black,
  surface: Colors.grey,
  onSurface: Colors.white,
  error: Colors.red,
  onError: Colors.black,
);
