// ignore_for_file: prefer_const_constructors

import 'package:delivery_app/screens/cart/cart_screen.dart';
import 'package:delivery_app/screens/order/order_screen.dart';
import 'package:delivery_app/screens/profile/profile_screen.dart';
import 'package:delivery_app/size_config.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Homepage(),
          CartScreen(),
          OrderScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: ((index) => setState(() {
                _currentIndex = index;
              })),
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_sharp),
              label: "orders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ]),
    );
  }
}
