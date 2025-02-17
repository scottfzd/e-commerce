import 'package:app/features/scanner/presentation/widgets/scan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          String? scannedResult = await ScanWidget.scanBarcode(context);
          if (scannedResult != null &&
              scannedResult.isNotEmpty &&
              scannedResult != '-1') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Résultat scanné : $scannedResult')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Aucun code-barres scanné')),
            );
          }
        },
        child: Text(AppLocalizations.of(context)!.scan_a_product),
      ),
    );
  }
}
