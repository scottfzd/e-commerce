import 'dart:io';

import 'package:app/features/profile/domain/entities/language_entity.dart';
import 'package:app/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageKey = 'selected_language';

  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    _loadSelectedLanguage();
  }

  Future<void> onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
    await _saveSelectedLanguage(event.selectedLanguage);
  }

  Future<void> _loadSelectedLanguage() async {
    final String? savedLanguageCode =
        sl<SharedPreferences>().getString(_languageKey);

    if (savedLanguageCode != null) {
      final Language savedLanguage = Language.values.firstWhere(
        (language) => language.value.languageCode == savedLanguageCode,
        orElse: () => Language.english,
      );
      add(ChangeLanguage(selectedLanguage: savedLanguage));
    } else {
      final String systemLanguageCode = Platform.localeName.split('_').first;
      final Language systemLanguage = Language.values.firstWhere(
        (language) => language.value.languageCode == systemLanguageCode,
        orElse: () => Language.english,
      );
      add(ChangeLanguage(selectedLanguage: systemLanguage));
    }
  }

  Future<void> _saveSelectedLanguage(Language language) async {
    await sl<SharedPreferences>()
        .setString(_languageKey, language.value.languageCode);
  }
}
