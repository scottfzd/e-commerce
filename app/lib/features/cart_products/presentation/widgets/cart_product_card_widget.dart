import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/presentation/blocs/cart_cubit.dart';
import 'package:app/shared/widgets/image_from_url_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartProductCardWidget extends StatelessWidget {
  final CartProductEntity cartProduct;
  final bool isModifiable;

  const CartProductCardWidget(
      {super.key, required this.cartProduct, this.isModifiable = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageFromUrlWidget(
                    imageUrl: cartProduct.product!.picture ?? '',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.product!.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          cartProduct.product!.brands!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        if (cartProduct.product!.categories != null)
                          Text(
                            cartProduct.product!.categories!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        Text(
                          '${AppLocalizations.of(context)!.quantity}: ${cartProduct.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${cartProduct.price} €',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (isModifiable)
                          TextButton.icon(
                            onPressed: () async {
                              await context
                                  .read<CartCubit>()
                                  .removeProductFromCart(
                                    cartProduct.id!,
                                  );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: Colors.red,
                            ),
                            icon: const Icon(Icons.delete, size: 18),
                            label: Text(
                              AppLocalizations.of(context)!.remove_item,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
