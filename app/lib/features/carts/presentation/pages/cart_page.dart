import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:app/service_locator.dart';
import 'package:app/features/cart_products/domain/repositories/cart_product_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final cartData = await sl<CartRepository>().getMyCart();

    print('GETTING CART DATA');
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
      print('HOPEFULLY GOT CART DATA');

    });
  }

  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 41),
              child: cart == null ? 
              const Center(child: CircularProgressIndicator()) : 
              Text('${AppLocalizations.of(context)!.cart.toUpperCase()} (${cart.products.length} ${AppLocalizations.of(context)!.products})')

            ),
            if (cartProducts != null && cart!= null)
              for (var product in cartProducts) ...[
                Card(
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
                        Image.network(product.product.picture),
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
                              Text(product.product.name),
                              Text(product.product.brands),
                              if (product.product.categories != '')
                                Text(product.product.categories),
                              // for (var info in product.product.nutritionalInfo)
                                // Text(info),
                              Text('Qté: ${product.quantity}'),
                              Text('${product.price} €')
                            ]
                          ),
                          TextButton(
                            onPressed: () async {
                              print('TODO: api call to remove item from cart');
                              final result = await sl<CartProductRepository>().removeProductFromCart(product.id);

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
                            // child: const Text('Remove item'),
                            child: Text(AppLocalizations.of(context)!.remove_item),
                          ),
    
                        ]
                      )
                      )
                    ]
                  ),
                ),
                ),
                const SizedBox(height: 31)
              ],
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 50, right: 21, bottom: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppLocalizations.of(context)!.subtotal}: ${cart.total} €'),
                    Text('${AppLocalizations.of(context)!.delivery_fee}: ${AppLocalizations.of(context)!.free_delivery}'),
                    Text('TOTAL: ${cart.total} €')
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
        )
      );
  }
}