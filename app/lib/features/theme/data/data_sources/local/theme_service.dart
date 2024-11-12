import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeService {
  Future<bool> getTheme();
  Future<Either> setTheme({required bool isDarkTheme});
}

class ThemeServiceImpl extends ThemeService {
  @override
  Future<bool> getTheme() async {
    return (sl<SharedPreferences>()).getBool('isDarkTheme') ??
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
  }

  @override
  Future<Either> setTheme({required bool isDarkTheme}) async {
    await sl<SharedPreferences>().setBool('isDarkTheme', isDarkTheme);
    return const Right(true);
  }
}
