import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:app/service_locator.dart';


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

    print('I BET YOU THINK ABOUT ME YES I BET YOU THINK ABOUT ME');
    print(cartData);
    setState(() {
      // cart = cartData;

      cartData.fold(
        (failure) {
          cart = null;
          cartProducts = null;
        },
        (cartModel) {
          print(cartModel);
          cart = cartModel;
          cartProducts = cart.products;
          print(cartProducts[0].product);
        }
      );
      print('YOU GREW UP IN A SILVER SPOON GATED COMMUNITY');

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
              Text('PANIER (${cart.products.length} articles)')

            ),
            if (cartProducts != null)
              for (var product in cartProducts) ...[
                Row(
                  children: [
                    Image.network(product.product.picture, width: 200, height: 200),
                    Container(
                      width: 211,
                      height: 200,
                      padding: const EdgeInsets.only(left: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.product.name),
                              Text(product.product.brand),
                              if (product.product.category != '')
                                Text(product.product.category),
                              // for (var info in product.product.nutritionalInfo)
                                // Text(info),
                              Text('Qté: ${product.quantity}'),
                              Text('${product.price} €')
                            ]
                          ),
                          TextButton(
                            onPressed: () {
                              print('TODO: api call to remove item from cart');
                            }, 
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.zero
                            ),
                            child: const Text('Remove item'),
                          ),
    
                        ]
                      )
                    )
                  ]
                ),
                const SizedBox(height: 41)
              ],
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 50, right: 21, bottom: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sous-total: ${cart.total} €'),
                    const Text('Livraison: Gratuit'),
                    Text('TOTAL: ${cart.total} €')
                  ]
                )
              ),
              ElevatedButton(
                onPressed: () {
                  print('pressed');
                }, 
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87
                ),
                child: const Text('Valider le panier')
              )
          ]
        )
      );
  }
}
