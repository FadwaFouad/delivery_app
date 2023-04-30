import 'package:delivery_app/data/models/restaurant.dart';
import 'package:delivery_app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/home/components/home/user_info.dart';
import 'package:delivery_app/screens/home/components/home/restaurant_item.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Restaurant> restaurantData = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                minWidth: double.infinity,
                height: 45,
                onPressed: () async {
                  try {
                    // loading
                    setState(() => _isLoading = true);
                    //get restaurant data from service
                    var data =
                        await locationProvider.retrieveNearbyRestaurants();
                    // convert data to list
                    restaurantData = locationProvider.toListOfRestaurant(data);
                    print(restaurantData.length);
                    // stop loading
                    setState(() => _isLoading = false);
                  } catch (error) {
                    setState(() => _isLoading = false);
                    var snackBar = SnackBar(content: Text(error.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Popular',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey)),
            ),
            SizedBox(height: 5),
            // list of retaurants
            Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : !_isLoading && restaurantData.length == 0
                        ? Center(child: Text('get restaurants around you!'))
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
