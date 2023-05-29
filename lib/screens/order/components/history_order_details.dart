import 'package:delivery_app/constants.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/order.dart';
import '../../../data/services/order_service.dart';
import '../../../providers/order_provider.dart';
import '../../../size_config.dart';
import '../../cart/components/default_button.dart' as cart;
import 'helper.dart' as helper;

class HistoryOrderDetails extends StatelessWidget {
  final Order order;
  const HistoryOrderDetails(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15),
          // header
          Row(
            children: [
              SizedBox(width: 5),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(width: 15),
              Text(
                'Order #${order.number.toString().padLeft(2, '0')}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          SizedBox(height: 20),
          // order details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                helper.getOrderDetailsStyle(
                    'Date:', helper.getDateStyle(order.dateTime)),
                SizedBox(height: 5),
                helper.getOrderDetailsStyle('Payment Type:', order.paymentType),
                SizedBox(height: 5),
                helper.getOrderDetailsStyle(
                    'Order Status:', helper.getOrderStatusName(order.status)),
                Divider(thickness: 1.5),
                SizedBox(height: 10),
                // items section
                Text('Items',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic)),

                SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: SizeConfig.screenHeight * 0.40,
                  // get foods list for each item from server
                  child: getListOfFood(order.id ?? ''),
                ),
                SizedBox(height: 10),
                Divider(thickness: 1.5),
                SizedBox(height: 20),
                // total price section
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${order.totalPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: CartWidget(
            cartBuilder: (controller) => cart.DefaultButton(
              text: 'Reorder',
              press: () {
                print(order.items.length);
                for (var cart in order.items) controller.addItem(cart);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(" items added to cart")));
              },
            ),
          ),
        ),
      ),
    );
  }

  getListOfFood(String orderID) {
    return Consumer(builder: (context, ref, child) {
      var data = ref.watch(foodItemsOfOrderProvider(orderID));
      return data.when(
          loading: () => const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey,
              )),
          error: (error, trace) => Center(child: Text('$error')),
          data: (data) {
            var foodList = data.docs
                .map((doc) => OrderService().foodItemsFromFirestore(doc))
                .toList();
            // add food list to items of data to use in reorder button
            order.items = foodList;
            return ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  // the food items inside order
                  var foodItem = foodList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                      child: Text(
                        'x${foodItem.quantity.toString()}',
                      ),
                    ),
                    title: Expanded(
                      child: Text(
                        foodItem.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            foodItem.additionalData['restaurant'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "\$${foodItem.price}",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor),
                    ),
                  );
                });
          });
    });
  }
}
