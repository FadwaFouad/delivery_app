import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// get menu data from firestore
final dataStreamProvider =
    StreamProvider.autoDispose.family<QuerySnapshot, String>((ref, name) {
  return FirebaseFirestore.instance.collection(name).snapshots();
});

// get near restaurant from location service
final locationProvider = LocationService();
