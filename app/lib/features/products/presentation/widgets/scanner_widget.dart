import 'package:app/features/products/presentation/blocs/products_cubit.dart';
import 'package:app/features/products/presentation/widgets/scan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScannerWidget extends StatelessWidget {
  const ScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String? barcode = await ScanWidget.scanBarcode(context);
        if (!context.mounted) return;
        if (barcode != null && barcode != '-1') {
          //barcode = '1234567890123';
          context.read<ProductsCubit>().fetchProductByBarcode(barcode);
        } else {
          Fluttertoast.showToast(
            msg: 'Aucun code-barre scanné',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: const Icon(Icons.barcode_reader),
    );
  }
}
