import 'package:delivery_app/data/models/order.dart';
import 'package:delivery_app/screens/order/components/acrive_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../providers/order_provider.dart';

class ActiveOrder extends ConsumerWidget {
  const ActiveOrder({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final orderData = ref.watch(activeOrderDataProvider);

    return orderData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, trace) {
          print('$error');

          return Center(child: Text('$error'));
        },
        data: (data) {
          // get order list
          var orderList =
              data.docs.map((doc) => Order.fromFirestore(doc)).toList();

          return orderList.isEmpty
              ? const Center(
                  child: Text(
                  'no active orders',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ))
              : ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    var order = orderList[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActiveOrderDetails(order),
                          )),
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 7,
                        child: ListTile(
                          // style date
                          leading: getDateStyle(order.dateTime),
                          // show number with two digit of Zero
                          title: Row(
                            children: [
                              Text(
                                'Order #${order.number.toString().padLeft(2, '0')},',
                              ),
                              SizedBox(width: 10),
                              Text(
                                order.paymentType,
                                style: TextStyle(
                                    color: Colors.orange.shade700,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Total Price: \$${order.totalPrice}',
                            style: TextStyle(fontSize: 12.5),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade100,
                            ),
                            child: getPaymentStatus(order.status),
                          ),
                        ),
                      ),
                    );
                  },
                );
        });
  }

  getDateStyle(DateTime dateTime) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${dateTime.day.toString()} ${DateFormat('MMM').format(dateTime)}',
          style: TextStyle(color: kPrimaryColor.shade800, fontSize: 12),
        ),
        Text(
          dateTime.year.toString(),
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget getPaymentStatus(int status) {
    switch (status) {
      case 0:
        return Text(
          'Received',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      case 1:
        return Text(
          'Cooked',
          style: TextStyle(
            color: Colors.yellow.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      case 2:
        return Text(
          'On Way',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      case 3:
        return Text(
          'Delivered',
          style: TextStyle(color: Colors.green),
        );
      default:
        return Text(
          'Received',
          style: TextStyle(color: Colors.red),
        );
    }
  }
}
