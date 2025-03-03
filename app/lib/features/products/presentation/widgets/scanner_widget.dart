import 'package:app/features/products/presentation/blocs/products_cubit.dart';
import 'package:app/features/products/presentation/widgets/scan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannerWidget extends StatelessWidget {
  const ScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String? barcode = await ScanWidget.scanBarcode(context);
        if (barcode != null) {
          debugPrint('Code-barre scanné : $barcode');
          if (!context.mounted) return;
          context.read<ProductsCubit>().fetchProductByBarcode(barcode);
        } else {
          debugPrint('Aucun code-barre scanné');
        }
      },
      child: const Icon(Icons.barcode_reader),
    );
  }
}
