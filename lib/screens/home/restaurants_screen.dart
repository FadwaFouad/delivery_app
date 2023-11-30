import 'package:delivery_app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart' as cons;
import '../../data/models/food.dart';
import 'components/restaurant/categories.dart';
import 'components/restaurant/food_item.dart';
import 'components/restaurant/search_field.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});
  static const routeName = '/restaurantScreen';

  @override
  Widget build(BuildContext context, ref) {
    //get passed arguments
    final String restaruantName =
        ModalRoute.of(context)!.settings.arguments as String;

    // get data from provider
    final _data = ref.watch(menuDataProvider(cons.restaurantName));
    final categoryProvider = ref.watch(categoryFoodProvider);
    final searchProvider = ref.watch(searchFoodProvider);

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
                  onPressed: () {
                    clearPreviousData(ref);
                    Navigator.pop(context);
                  },
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
            SearchField(),
            SizedBox(height: 10),
            CategoriesList(),
            SizedBox(height: 10),
            Expanded(
              child: _data.when(
                  data: (data) {
                    List<Food> foodList = data.docs
                        .map((doc) => Food.fromFirestore(doc))
                        .toList();
                    foodList = nearbyRestaurantProvider.getCategoryItems(
                        categoryProvider, foodList);
                    foodList = nearbyRestaurantProvider.searchFood(
                        searchProvider, foodList);
                    return foodList.isEmpty
                        ? const Center(
                            child: Text(
                            'no menu available',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ))
                        : GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                            ),
                            children: List.generate(foodList.length, (index) {
                              return FoodItem(
                                  item: foodList[index],
                                  resName: restaruantName);
                            }),
                          );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, trace) => const Center(child: Text('Error'))),
            ),
          ],
        ),
      ),
    );
  }

  void clearPreviousData(ref) {
    ref.read(searchFoodProvider.notifier).state = '';
    ref.read(categoryFoodProvider.notifier).state = "All";
  }
}
