import 'package:app/features/payment/presentation/pages/payment_page.dart';
import 'package:app/shared/widgets/image_from_url_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/service_locator.dart';
import 'package:app/features/cart_products/domain/repositories/cart_product_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/carts/presentation/blocs/cart_cubit.dart';
import 'package:app/features/carts/presentation/blocs/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..fetchCart(),
      child: Scaffold(
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final cart = state.cart;
              final cartProducts = cart.products;

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                        '${AppLocalizations.of(context)!.cart.toUpperCase()} (${cart.products?.length} ${AppLocalizations.of(context)!.products})'),
                  ),
                  if (cartProducts != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          var product = cartProducts[index];
                          return Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Card(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 200,
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 140,
                                      width: 140,
                                      child: ImageFromUrlWidget(
                                        imageUrl:
                                            product.product!.picture ?? '',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(product.product!.name!),
                                              Text(product.product!.brands!),
                                              if (product.product!.categories !=
                                                  null)
                                                Text(product
                                                    .product!.categories!),
                                              Text(
                                                  '${AppLocalizations.of(context)!.quantity}: ${product.quantity}'),
                                              Text('${product.price} €'),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              final result = await sl<
                                                      CartProductRepository>()
                                                  .removeProductFromCart(
                                                      product.id!);

                                              result.fold(
                                                (failure) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Erreur: Article non supprimé');
                                                },
                                                (success) {
                                                  Fluttertoast.showToast(
                                                      msg: 'Article supprimé');
                                                },
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .remove_item,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${AppLocalizations.of(context)!.subtotal}: '),
                            Text('${cart.total} €'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${AppLocalizations.of(context)!.delivery_fee}: '),
                            Text(AppLocalizations.of(context)!.free_delivery)
                          ],
                        ),
                        const SizedBox(height: 21),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('TOTAL: '),
                            Text('${cart.total} €')
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black87,
                      ),
                      child: Text(AppLocalizations.of(context)!.validate_cart),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Cart Empty');
            }
          },
        ),
      ),
    );
  }
}
