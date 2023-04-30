import 'package:delivery_app/providers/auth_provider.dart';
import 'package:delivery_app/screens/home/food_screen.dart';
import 'package:delivery_app/screens/home/restaurants_screen.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bottom_nav.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final authState = ref.watch(authStateProvider);
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RobotoSlab',
        primarySwatch: Colors.orange,
      ),
      home: authState.when(
          data: (data) {
            return data != null ? const BottomNav() : const LoginPage();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, trace) => const Center(child: Text('Error'))),
      routes: {
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        FoodScreen.routeName: (context) => FoodScreen(),
        LoginPage.routeName: (context) => const LoginPage(),
      },
    );
  }
}
