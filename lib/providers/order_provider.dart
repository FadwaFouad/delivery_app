import 'package:delivery_app/data/services/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = Provider<OrderService>((ref) {
  return OrderService();
});
