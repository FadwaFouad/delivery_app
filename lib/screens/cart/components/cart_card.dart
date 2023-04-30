import 'package:flutter/material.dart';

import '../../../constants.dart' as cons;
import '../../../data/models/food.dart';
import '../../../size.config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 65,
              child: AspectRatio(
                aspectRatio: 0.85,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(food.image),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ' ${food.name}, ',
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                      maxLines: 2,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.location_pin,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    Text(
                      food.restaurant,
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.remove_circle_outline_sharp),
                color: Colors.grey,
                onPressed: () {}),
            Text(
              '1',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Colors.grey,
                onPressed: () {}),
          ],
        ),
        Divider(),
      ],
    );
  }
}
