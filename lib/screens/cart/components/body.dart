import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';

import '../../../size.config.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return CartWidget(
      cartBuilder: (controller) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: ListView.builder(
          itemCount: controller.cartList.length,
          itemBuilder: (context, index) => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Dismissible(
                  // give unique key for item
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.removeItem(controller.cartList[index]);
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(Icons.delete, color: Colors.red)
                      ],
                    ),
                  ),
                  child: CartCard(food: controller.cartList[index]),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
