import 'package:delivery_app/data/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locProvider = Provider<LocationService>((ref) {
  return LocationService();
});
