import 'dart:async';

import 'package:app/core/styles/themes/system_ui_overlay_style.dart';
import 'package:app/features/theme/domain/repositories/theme_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepository themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState());

  final ThemeRepository _themeRepository;
  static late bool _isDarkTheme;

  void _setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      _isDarkTheme ? darkSystemUiOverlayStyle : lightSystemUiOverlayStyle,
    );
  }

  Future<void> getCurrentTheme() async {
    final isDarkTheme = await _themeRepository.getTheme();
    _isDarkTheme = isDarkTheme;
    _setSystemUIOverlayStyle();
    emit(state.copyWith(
        themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> switchTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _themeRepository.setTheme(isDarkTheme: _isDarkTheme);
    _setSystemUIOverlayStyle();
    emit(state.copyWith(
        themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light));
  }
}
