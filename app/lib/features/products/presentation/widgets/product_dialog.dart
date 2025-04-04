import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/presentation/blocs/products_cubit.dart';
import 'package:app/shared/widgets/image_from_url_widget.dart';
import 'package:app/shared/widgets/quantity_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDialog extends StatefulWidget {
  final ProductEntity product;

  const ProductDialog({super.key, required this.product});
  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  int selectedQuantity = 1;

  void quantityChanged(int newQuantity) {
    setState(() {
      selectedQuantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product.name!),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: ImageFromUrlWidget(imageUrl: widget.product.picture ?? ''),
            ),
            const SizedBox(height: 8),
            QuantitySelector(
              quantity: widget.product.stock?.quantity ?? 1,
              onChanged: quantityChanged,
            ),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context)!.price} : ${widget.product.stock!.price.toString()} €'),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.close),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<ProductsCubit>()
                    .addProductToCart(widget.product, selectedQuantity);
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.add_to_cart),
            ),
          ],
        ),
      ],
    );
  }
}
