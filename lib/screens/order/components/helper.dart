import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

String getDateStyle(DateTime dateTime) {
  return '${dateTime.day.toString()}-${DateFormat('MMM').format(dateTime)}-${dateTime.year.toString()}';
}

getOrderDetailsStyle(name, details) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: kPrimaryColor.shade700),
      ),
      Text(
        details,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    ],
  );
}

getOrderStatusName(int status) {
  switch (status) {
    case 0:
      return 'Received';

    case 1:
      return 'Cooked';
    case 2:
      return 'On Way';
    case 3:
      return 'Delivered';
    default:
      'Received';
  }
}
