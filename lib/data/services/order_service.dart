import '../models/order.dart';

class OrderService {
  int _orderNumber = 0;

  List<Order> _orderList = [];

  void addOrder(Order order) {
    _orderList.add(order);
  }
  // _orderNumber.toString().padLeft(2, '0');

  int get getNumOfOrder => ++_orderNumber;
  List<Order> get getOrderList => _orderList;
}
