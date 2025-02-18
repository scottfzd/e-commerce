import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:app/service_locator.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    print('I AM IN');

    _loadCartData();

  }

  Future<void> _loadCartData() async {
    final cart = await sl<CartRepository>().getCartById(47);
    print(cart);
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
      return const Scaffold(
        body: Text('HELLO'),
      );
    // );
  }
}
