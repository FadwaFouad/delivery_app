import 'package:delivery_app/data/models/food.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import 'components/food/item_image.dart';
import 'components/food/order_button.dart';

class FoodScreen extends StatelessWidget {
  static const routeName = '/foodScreen';

  @override
  Widget build(BuildContext context) {
    Food foodItem = ModalRoute.of(context)!.settings.arguments as Food;

    return Scaffold(
        backgroundColor: kPrimaryColor.shade300,
        appBar: AppBar(
          backgroundColor: kPrimaryColor.shade300,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: <Widget>[
            ItemImage(
              imgSrc: foodItem.image,
            ),
            Expanded(
              child: ItemInfo(context, foodItem),
            ),
          ],
        ));
  }
}

Widget ItemInfo(context, Food food) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(20),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          shopeName(name: food.restaurant),
          foodTitle(context, food),
          // des
          Text(
            food.description,
            style: TextStyle(
              height: 1.5,
            ),
          ),
          SizedBox(height: 50),
          // Free space  10% of total height
          OrderButton(
            size: size,
          )
        ],
      ),
    ),
  );
}

Widget foodTitle(context, Food item) {
  return Column(
    children: [
      SizedBox(height: 10),
      Text(
        item.name,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      Row(
        children: <Widget>[
          Icon(
            Icons.currency_pound,
            color: Colors.orange,
          ),
          Text(
            item.price.toString(),
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      SizedBox(height: 5),
    ],
  );
}

Row shopeName({required String name}) {
  return Row(
    children: <Widget>[
      Icon(
        Icons.location_on,
        color: ksecondaryColor,
      ),
      SizedBox(width: 10),
      Text(name),
    ],
  );
}
