import 'package:delivery_app/data/models/restaurant.dart';
import 'package:delivery_app/data/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/home/components/home/user_info.dart';
import 'package:delivery_app/screens/home/components/home/near_button.dart';
import 'package:delivery_app/screens/home/components/home/restaurant_item.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurantData = Repository().getRestaurantList();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            UserInfo(),
            SizedBox(height: 2),
            ButtonNearst(),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemCount: restaurantData.length,
              itemBuilder: (ctx, index) {
                return RestaurantItem(restaurat: restaurantData[index]);
              },
            )),
          ],
        ),
      ),
    );
  }
}
