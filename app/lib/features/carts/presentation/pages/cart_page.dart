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
          return const Center(child: Text('Failed to load cart'));
        },
        (cartModel) {
          cart = cartModel;
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
              child:
              cart == null ? 
              const Center(child: CircularProgressIndicator()) : 
              Text('PANIER (${cart.products.length} articles)')

            ),
            for (var product in cart.products) ...[
              Row(
                children: [
                  Image.network(product.picture, width: 200, height: 200),
                  SizedBox(
                    width: 211,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name),
                            Text(product.brand),
                            if (product.category != '')
                              Text(product.category),
                            for (var info in product.nutritionalInfo)
                              Text(info),
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
            ]
          ]
        )
      );
  }
}
