import 'package:delivery_app/data/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/home/components/home/user_info.dart';
import 'package:delivery_app/screens/home/components/home/restaurant_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/location_provider.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    List<Restaurant> restaurantData = [];
    bool _isLoading = false;
    // final List<Restaurant> restaurantData = Repository().getRestaurantList();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            UserInfo(),
            SizedBox(height: 2),

            //nearest buttun
            Container(
              padding: EdgeInsets.all(10),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 45,
                onPressed: () async {
                  _isLoading = true;
                  // get restaurant data from service
                  restaurantData = await ref
                      .read(locProvider)
                      .retrieveNearbyRestaurants()
                      .whenComplete(() => _isLoading = false);
                  // Position position = await LocationService().getCurrentLocation();
                  // print('${position.latitude},${position.longitude},');
                },
                color: Colors.orange.shade300,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  'Get Nearest Restauratns',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // list of retaurants
            Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : !_isLoading && restaurantData.length == 0
                        ? Center(child: Text('no restaurants around you!'))
                        : ListView.builder(
                            itemCount: restaurantData.length,
                            itemBuilder: (ctx, index) {
                              return RestaurantItem(
                                  restaurat: restaurantData[index]);
                            },
                          )),
          ],
        ),
      ),
    );
  }
}
