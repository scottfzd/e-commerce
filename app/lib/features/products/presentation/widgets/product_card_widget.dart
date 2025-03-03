import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/presentation/widgets/product_dialog.dart';
import 'package:app/shared/widgets/image_from_url_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProductDialog(product: product),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(product.name!),
              const SizedBox(height: 2),
              Expanded(
                child: ImageFromUrlWidget(imageUrl: product.picture!),
              ),
              const SizedBox(height: 2),
              Text('${product.stock!.price} €'),
              const SizedBox(height: 2),
              if (product.stock!.quantity == 0)
                Text(AppLocalizations.of(context)!.out_of_stock),
            ],
          ),
        ),
      ),
    );
  }
}
