import 'package:app/features/profile/domain/entities/language_entity.dart';
import 'package:app/features/profile/presentation/blocs/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget languageMode(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Languages'),
      const SizedBox(width: 10),
      DropdownButton<String>(
        value: AppLocalizations.of(context)!.localeName,
        items: AppLocalizations.supportedLocales
            .map((locale) => DropdownMenuItem(
                  value: locale.languageCode,
                  child: Text(locale.languageCode),
                ))
            .toList(),
        onChanged: (String? value) {
          final Language selectedLanguage = Language.values.firstWhere(
            (language) => language.value.languageCode == value,
            orElse: () => Language.english,
          );
          context
              .read<LanguageBloc>()
              .add(ChangeLanguage(selectedLanguage: selectedLanguage));
        },
      ),
    ],
  );
}
