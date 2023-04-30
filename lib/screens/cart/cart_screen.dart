import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import 'components/body.dart';
import 'components/checkout_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: const CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "My Cart, ",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          CartWidget(
            cartBuilder: (controller) => Text(
              "${controller.cartList.length} items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
