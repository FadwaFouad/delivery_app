import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key});
  @override
  Widget build(BuildContext context) {
    List<TextDto> orderList = [
      TextDto("Your order has been placed & working on it", null),
    ];

    List<TextDto> shippedList = [
      TextDto("Your order has been prepared by our restaurants", null),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is ready and on way to your location", null),
    ];

    List<TextDto> deliveredList = [
      TextDto("Order Delivered, enjoy and have fun!", null),
    ];

    return OrderTracker(
      status: Status.order,
      activeColor: kPrimaryColor.shade400,
      inActiveColor: Colors.grey[300],
      headingTitleStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      subTitleTextStyle: TextStyle(color: Colors.black54),
      orderTitleAndDateList: orderList,
      shippedTitleAndDateList: shippedList,
      outOfDeliveryTitleAndDateList: outOfDeliveryList,
      deliveredTitleAndDateList: deliveredList,
    );
  }
}
