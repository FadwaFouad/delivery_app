import 'package:delivery_app/constants.dart' as cons;
import 'package:flutter/material.dart';

import 'components/active_order.dart';
import 'components/history_order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Orders'),
          bottom: TabBar(
              indicatorColor: cons.kPrimaryColor,
              labelColor: cons.kPrimaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Active',
                ),
                Tab(
                  text: 'History',
                )
              ]),
        ),
        body: TabBarView(children: [
          ActiveOrder(),
          HistoryOrder(),
        ]),
      ),
    );
  }
}
