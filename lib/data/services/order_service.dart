import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_cart/fancy_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order.dart' as models;

class OrderService {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  int _orderNumber = 0;

  int get getNumOfOrder => ++_orderNumber;

// save orders in firestore
  Future<void> addOrder(models.Order order) async {
    // save order per  user
    final orderCollection =
        FirebaseFirestore.instance.collection('users/$uid/orders');
    // save order in firestore
    var orderResult = await orderCollection.add({
      'number': order.number,
      'dateTime': Timestamp.fromDate(order.dateTime),
      'paymentType': order.paymentType,
      'status': order.status,
      'totalPrice': order.totalPrice,
    });

    // save list of foods of order in new collection of same order by order ID
    for (var item in order.items) {
      await orderCollection.doc(orderResult.id).collection('items').add({
        'id': item.id,
        'image': item.image,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
        'restaurant': item.additionalData['restaurant'],
      });
    }
  }

// get food items for each order use Order ID
  Stream<QuerySnapshot<Object?>> getFoodItemsOfOrder(String orderID) {
    // get order per  user
    final orderCollection =
        FirebaseFirestore.instance.collection('users/$uid/orders');
    return orderCollection.doc(orderID).collection('items').snapshots();
  }

  Stream<QuerySnapshot<Object?>> getHistoryOrderData() {
    final orderCollection =
        FirebaseFirestore.instance.collection('users/$uid/orders');
    return orderCollection
        // when status is (0,1,2) that mean the order is active
        .where('status', isEqualTo: 3)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> getActiveOrderData() {
    final orderCollection =
        FirebaseFirestore.instance.collection('users/$uid/orders');
    return orderCollection
        // when status is (3=> Delevired ) that mean it's a history order
        .where('status', whereIn: [0, 1, 2])
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

// convert order items from firestore to object
  CartItem foodItemsFromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: data['id'],
      image: data['image'],
      name: data['name'],
      price: data['price'],
      quantity: data['quantity'],
      additionalData: {'restaurant': data['restaurant']},
    );
  }
}
