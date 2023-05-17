import 'package:fancy_cart/fancy_cart.dart';

// ignore: constant_identifier_names
// enum OrderStatus { Received, Cooked, Onway, Delivered }

class Order {
  int number;
  DateTime dateTime;
  double totalPrice;
  List<CartItem> items;
  int status;
  String paymentType;

  Order({
    required this.number,
    required this.dateTime,
    required this.items,
    required this.status,
    required this.totalPrice,
    required this.paymentType,
  });
}
