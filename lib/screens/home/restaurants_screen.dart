import 'package:delivery_app/data/models/food.dart';
import 'package:flutter/material.dart';

import '../../data/repo/repo.dart';
import 'components/restaurant/categories.dart';
import 'components/restaurant/food_item.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});
  static const routeName = '/restaurantScreen';

  @override
  Widget build(BuildContext context) {
    final List<Food> foodList = Repository().getFoodList();
    final String restaruantName =
        ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 5),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_rounded),
                ),
                SizedBox(width: 15),
                Text(
                  restaruantName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for a dish",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            CategoriesList(),
            SizedBox(height: 10),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                children: List.generate(foodList.length, (index) {
                  return FoodItem(item: foodList[index]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
