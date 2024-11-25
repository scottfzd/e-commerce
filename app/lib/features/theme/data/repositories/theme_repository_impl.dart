import 'package:app/features/theme/data/data_sources/local/theme_service.dart';
import 'package:app/features/theme/domain/repositories/theme_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  @override
  Future<bool> getTheme() async {
    return await sl<ThemeService>().getTheme();
  }

  @override
  Future<Either> setTheme({required bool isDarkTheme}) async {
    return await sl<ThemeService>().setTheme(isDarkTheme: isDarkTheme);
  }
}
