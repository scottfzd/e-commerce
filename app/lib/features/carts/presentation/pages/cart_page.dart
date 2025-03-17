import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:app/service_locator.dart';
import 'package:app/features/cart_products/domain/repositories/cart_product_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/features/carts/presentation/blocs/cart_cubit.dart';
import 'package:app/features/carts/presentation/blocs/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var cart;
  var cartProducts;
  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    final shopIdString = await sl<FlutterSecureStorage>().read(key: 'refresh_token');
    print(shopIdString);
    final shopId = int.tryParse(shopIdString ?? '') ?? 0; 
    final cartData = await sl<CartRepository>().getMyCart(shopId);

    final selectedShopId = await sl<FlutterSecureStorage>().read(key: 'shopId');

    final cartData = await sl<CartRepository>().getMyCart(selectedShopId);

    print(cartData);
    setState(() {

      cartData.fold(
        (failure) {
          cart = null;
          cartProducts = null;
        },
        (cartModel) {
          print(cartModel);
          cart = cartModel;
          cartProducts = cart.products;
          // print(cartProducts[0].product);
        }
      );

    });
  }

  @override
  // Widget build(BuildContext context) {

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
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 41),
                      // child: cart == null ? 
                      // const Center(child: CircularProgressIndicator()) : 
                      child: Text('${AppLocalizations.of(context)!.cart.toUpperCase()} (${cart.products?.length} ${AppLocalizations.of(context)!.products})')

                    ),
                    if (cartProducts != null)
                      Expanded(
                        // height: 400,
                        child: 
                        ListView.builder(
                          itemCount: cartProducts.length,
                          itemBuilder: 
                          (context, index) {
                            var product = cartProducts[index];
                            return Card(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: 
                              Container(
                                height: 200,
                                padding: const EdgeInsets.all(10.0),
                                child: 
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 140,
                                      width: 140,
                                      child:
                                      Image.network(product.product?.picture ?? 'No picture available'),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: 
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(product.product!.name!),
                                            Text(product.product!.brands!),
                                            if (product.product!.categories != null)
                                              Text(product.product!.categories!),
                                            // for (var info in product.product.nutritionalInfo)
                                              // Text(info),
                                            Text('${AppLocalizations.of(context)!.quantity}: ${product.quantity}'),
                                            Text('${product.price} €')
                                          ]
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            print('TODO: api call to remove item from cart');
                                            final result = await sl<CartProductRepository>().removeProductFromCart(product.id!);

                                            result.fold(
                                              (failure) {
                                                Fluttertoast.showToast(msg: 
                                                'Erreur: Article non supprimé');
                                              },
                                              (success) {
                                                Fluttertoast.showToast(msg: 'Article supprimé');
                                                _loadCartData();
                                              }
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Text(AppLocalizations.of(context)!.remove_item),
                                        ),
                  
                                      ]
                                    )
                                    )
                                  ]
                                ),
                              ),
                            );
                          }
                        ),
                        // const SizedBox(height: 31),
                      ),
                      // const SizedBox(height: 31),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 41, right: 41, bottom: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${AppLocalizations.of(context)!.subtotal}: '),
                                Text('${cart.total} €')
                              ]
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${AppLocalizations.of(context)!.delivery_fee}: '),
                                Text(AppLocalizations.of(context)!.free_delivery)
                              ]
                            ),
                            const SizedBox(height: 21),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('TOTAL: '),
                                Text('${cart.total} €')
                              ]
                            )
                          ]
                        )
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () {
                            print('pressed');
                          }, 
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black87
                          ),
                          child: Text(AppLocalizations.of(context)!.validate_cart)
                        )
                      )
                  ]
                );
            } else {
              return const Text('Cart Empty');
            }
          }
        )
      )
    );
  }
}