import 'package:delivery_app/providers/auth_provider.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final _auth = ref.read(authProvider);

          return Center(
            child: ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Sign Out'),
            ),
          );
        },
      ),
    );
  }
}
