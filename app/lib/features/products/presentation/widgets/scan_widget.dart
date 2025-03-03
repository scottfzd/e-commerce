import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanWidget {
  static Future<String?> scanBarcode(BuildContext context) async {
    String? result = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scanner un code-barres',
        centerTitle: true,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 500,
      cameraFace: CameraFace.back,
      scanFormat: ScanFormat.ONLY_BARCODE,
    );
    return result;
  }
}
