import 'package:dartz/dartz.dart';

abstract class ThemeRepository {
  Future<bool> getTheme();
  Future<Either> setTheme({required bool isDarkTheme});
}
