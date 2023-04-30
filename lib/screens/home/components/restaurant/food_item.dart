import 'package:delivery_app/screens/home/food_screen.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/food.dart';

class FoodItem extends StatelessWidget {
  final Food item;
  final String resName;

  const FoodItem({super.key, required this.item, required this.resName});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, FoodScreen.routeName,
            arguments: {'food': item, 'res': resName}),
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Image.network(
                  item.image,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/loading_icon.gif');
                  },
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              SizedBox(
                height: 9.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              SizedBox(height: 5),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
