import 'package:delivery_app/data/models/restaurant.dart';
import 'package:delivery_app/screens/home/components/home/star_display.dart';
import 'package:flutter/material.dart';

import '../../restaurants_screen.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurat;
  RestaurantItem({super.key, required this.restaurat});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RestaurantScreen.routeName,
          arguments: restaurat.name),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              offset: Offset(0, 3),
              color: Colors.grey.shade300,
            ),
          ],
        ),
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              child: Image.network(
                restaurat.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/loading_icon.gif');
                },
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            SizedBox(
              height: 9.0,
            ),
            Text(
              restaurat.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 9.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.pin_drop,
                  color: Colors.grey[400],
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    restaurat.place,
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    child: StarDisplay(
                      value: restaurat.rate,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
