import 'dart:ui';

enum Language {
  french(
    Locale('fr', 'FR'),
    'Français',
  ),
  english(
    Locale('en', 'US'),
    'English',
  );

  const Language(
    this.value,
    this.text,
  );

  final Locale value;
  final String text;
}
