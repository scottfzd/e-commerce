import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';

class WebviewWidget {
  static void launchURL(BuildContext context, String url) {
    _launchURL(context, url);
  }

  static Future<void> _launchURL(BuildContext context, String url) async {
    final theme = Theme.of(context);

    try {
      await launchUrl(
        Uri.parse(url),
        options: LaunchOptions(
          barColor: theme.colorScheme.surface,
          onBarColor: theme.colorScheme.onSurface,
          barFixingEnabled: false,
        ),
      );
    } catch (e) {
      // Gestion des erreurs lorsque le lancement de l'URL échoue
      debugPrint('Error launching URL: $e');
    }
  }
}
