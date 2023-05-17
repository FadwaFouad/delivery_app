import 'package:delivery_app/screens/order/components/history_order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/order_provider.dart';
import 'helper.dart' as helper;

class HistoryOrder extends ConsumerWidget {
  const HistoryOrder({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // get list of order
    var orderList = ref.watch(orderProvider).getOrderList;
    return orderList.length == 0
        ? const Center(
            child: Text(
            'no history orders',
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
                      builder: (context) => HistoryOrderDetails(order),
                    )),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 7,
                  child: ListTile(
                    // style date
                    leading: Icon(
                      Icons.motorcycle_outlined,
                      color: Colors.green.shade700,
                      size: 28,
                    ),
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
                              color: Colors.orange.shade700, fontSize: 13),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      'Delivered on: ${helper.getDateStyle(order.dateTime)}',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Text(
                      '\$${order.totalPrice}',
                      style: TextStyle(
                        color: Colors.yellow.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
