import 'package:app/core/styles/app_colors.dart';
import 'package:app/core/styles/app_theme.dart';
import 'package:app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app/features/auth/presentation/bloc/auth_state.dart';
import 'package:app/features/auth/presentation/pages/login_page.dart';
import 'package:app/features/home/presentation/blocs/bottom_navigation_bloc.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/profile/presentation/blocs/language_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_cubit.dart';
import 'package:app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await dotenv.load(fileName: '.env');
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
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ThemeCubit(themeRepository: sl())..getCurrentTheme(),
        ),
        BlocProvider(
          create: (context) => sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme(AppColors.lightColors).getTheme(),
                darkTheme: AppTheme(AppColors.darkColors).getTheme(),
                themeMode: themeState.themeMode,
                locale:
                    context.read<LanguageBloc>().state.selectedLanguage.value,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                home: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    if (authState is Authenticated) {
                      return const HomePage();
                    } else if (authState is UnAuthenticated) {
                      return LoginPage();
                    } else {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
