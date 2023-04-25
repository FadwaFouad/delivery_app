import 'package:delivery_app/screens/home/food_screen.dart';
import 'package:delivery_app/screens/home/restaurants_screen.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.orange,
      ),
      home: const BottomNav(),
      routes: {
        RestaurantScreen.routeName: (context) => RestaurantScreen(),
        FoodScreen.routeName: (context) => FoodScreen(),
        LoginPage.routeName: (context) => LoginPage(),
      },
    );
  }
}
