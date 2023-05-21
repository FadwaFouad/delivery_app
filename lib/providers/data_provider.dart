import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/services/nearby_restaurant_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// get menu data from firestore
final menuDataProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, name) {
  return FirebaseFirestore.instance.collection(name).snapshots();
});

// get near restaurant from location service
final nearbyRestaurantProvider = NearbyRestaurantService();
