import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/services/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = Provider<OrderService>((ref) {
  return OrderService();
});

// get active order data from firestore
final activeOrderDataProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance
      .collection('Orders')
      // when status is (0,1,2) that mean the order is active
      .where('status', whereIn: [0, 1, 2])
      .orderBy('dateTime', descending: true)
      .snapshots();
});

final historyOrderDataProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance
      .collection('Orders')
      // when status is (3=> Delevired ) that mean it's a history order
      .where('status', isEqualTo: 3)
      .orderBy('dateTime', descending: true)
      .snapshots();
});

// get food list for each order use orderID
final foodItemsOfOrderProvider =
    StreamProvider.family<QuerySnapshot, String>((ref, orderID) {
  return OrderService().getFoodItemsOfOrder(orderID);
});
