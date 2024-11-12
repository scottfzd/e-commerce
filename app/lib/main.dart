import 'package:app/core/styles/app_colors.dart';
import 'package:app/core/styles/app_theme.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/theme/presentation/bloc/theme_cubit.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  sl.allReady().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ThemeCubit(themeRepository: sl())..getCurrentTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: AppTheme(AppColors.lightColors).getTheme(),
            darkTheme: AppTheme(AppColors.darkColors).getTheme(),
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
