import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/shared/widgets/image_from_url_widget.dart';
import 'package:flutter/material.dart';

class ProductDialog extends StatelessWidget {
  final ProductEntity product;

  const ProductDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.name!),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageFromUrlWidget(imageUrl: product.picture!),
            const SizedBox(height: 8),
            Text('Prix : ${product.stock!.price.toString()} €'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fermer'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ajouter au panier'),
        ),
      ],
    );
  }
}
