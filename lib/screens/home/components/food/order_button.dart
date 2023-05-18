import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../data/models/food.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
    required this.size,
    required this.food,
    required this.resName,
  });

  final Size size;
  final Food food;
  final String resName;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: size.width * 0.8,
      // it will cover 80% of total width
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),

      /// use fancy_cart to add foods to cart
      child: AddToCartButton(
        actionAfterAdding: () {
          String message = "${food.name} added to Cart";
          var snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        cartModel: CartItem(
            id: food.id,
            name: food.name,
            price: food.price,
            image: food.image,
            additionalData: {'restaurant': resName}),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.badge_sharp,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Order Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
