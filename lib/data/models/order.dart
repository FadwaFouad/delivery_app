import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_cart/fancy_cart.dart';

// ignore: constant_identifier_names
// enum OrderStatus { Received, Cooked, Onway, Delivered }

class Order {
  String? id;
  int number;
  DateTime dateTime;
  double totalPrice;
  List<CartItem> items;
  int status;
  String paymentType;

  Order({
    this.id,
    required this.number,
    required this.dateTime,
    required this.items,
    required this.status,
    required this.totalPrice,
    required this.paymentType,
  });

  factory Order.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // convert timestamp of firestore to date in flutter
    DateTime date = (data['dateTime'] as Timestamp).toDate();

    return Order(
      id: doc.id,
      number: data['number'],
      dateTime: date,
      paymentType: data['paymentType'],
      status: data['status'],
      totalPrice: data['totalPrice'],
      items: [],
    );
  }
}
