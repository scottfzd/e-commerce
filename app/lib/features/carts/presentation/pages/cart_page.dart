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
    // return Container(
      return Scaffold(
        body: Column(
          children: [
            Container(
              child:
              cart == null ? 
              const Center(child: CircularProgressIndicator()) : 
              Text('PANIER (${cart.products.length})')

            ),
            // Container(
              // child: Text('${cart.products[0].picture}'),
              Row(
                children: [
                  Image.network(cart.products[0].picture, width: 200, height: 200),
                  Column(
                    children: [
                      Text('${cart.products[0].name}'),
                      Text('${cart.products[0].brand}'),
                      if (cart.products[0].category != '')
                        Text('${cart.products[0].category}'),
                      for (var info in cart.products[0].nutritionalInfo)
                        Text(info),
                    ]
                  )
                ]
              )
            // )
          ]
        )
      );
    // );
  }
}
