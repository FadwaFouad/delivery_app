import 'package:flutter/material.dart';

import '../../../data/dummy_data.dart';
import '../../../size.config.dart';
import 'cart_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Dismissible(
                // give unique key for item
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {},
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [Spacer(), Icon(Icons.delete, color: Colors.red)],
                  ),
                ),
                child: CartCard(food: foodList[index]),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
