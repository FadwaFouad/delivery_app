import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart' as cons;
import '../../../size.config.dart' as size;

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  final CartItem food;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.SizeConfig.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 65,
                  child: AspectRatio(
                    aspectRatio: 0.85,
                    child: Container(
                      padding:
                          EdgeInsets.all(size.getProportionateScreenWidth(5)),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(
                        food.image,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/loading_icon.gif');
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              '${food.name}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 17),
                              maxLines: 1,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "\$${food.price}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: cons.kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey[400],
                            size: 20,
                          ),
                          Expanded(
                            child: Text(
                              food.additionalData['restaurant'],
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: size.SizeConfig.screenWidth * 0.3,
            child: CartWidget(
              cartBuilder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove_circle_outline_sharp),
                      color: Colors.grey,
                      onPressed: () => controller.decrementItemQuantity(food)),
                  Text(
                    food.quantity.toString(),
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: Colors.grey,
                      onPressed: () => controller.incrementItemQuantity(food)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
