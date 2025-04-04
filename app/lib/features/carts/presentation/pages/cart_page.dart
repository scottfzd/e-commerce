import 'package:app/features/cart_products/presentation/widgets/cart_product_card_widget.dart';
import 'package:app/features/payment/presentation/pages/payment_page.dart';
import 'package:flutter/material.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit()..fetchCart(),
        ),
      ],
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
                          return CartProductCardWidget(
                            cartProduct: product,
                            isModifiable: true,
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
