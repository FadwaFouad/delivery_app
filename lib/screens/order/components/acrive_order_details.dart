import 'package:delivery_app/data/models/order.dart';
import 'package:flutter/material.dart';
import 'helper.dart' as helper;
import 'order_timeline.dart';

class ActiveOrderDetails extends StatelessWidget {
  final Order order;
  const ActiveOrderDetails(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            'Order #${order.number.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
      SizedBox(height: 40),
      // order details
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            helper.getOrderDetailsStyle(
                'Date:', helper.getDateStyle(order.dateTime)),
            SizedBox(height: 5),
            helper.getOrderDetailsStyle('Payment Type:', order.paymentType),
            SizedBox(height: 5),
            helper.getOrderDetailsStyle(
                'Total Price:', '\$${order.totalPrice}'),
            Divider(thickness: 1.5),
            SizedBox(height: 30),
            // order status section
            Text('Order Status',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1)),
            // oreder time line
            SizedBox(height: 25),
            OrderTimeline(),
            SizedBox(height: 15),
            Divider(thickness: 1.5),
          ]))
    ])));
  }
}
