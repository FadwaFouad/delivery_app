import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/services/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = Provider<OrderService>((ref) {
  return OrderService();
});

// get active order data from firestore
final activeOrderDataProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return OrderService().getActiveOrderData();
});

// get history data from firestore
final historyOrderDataProvider =
    StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return OrderService().getHistoryOrderData();
});

// get food list for each order use orderID
final foodItemsOfOrderProvider =
    StreamProvider.family<QuerySnapshot, String>((ref, orderID) {
  return OrderService().getFoodItemsOfOrder(orderID);
});
