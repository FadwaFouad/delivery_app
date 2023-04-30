import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../login/login_screen.dart';
import 'components/profile_bar.dart';
import 'components/profile_menu.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: MediaQuery.of(context).size.height - 10,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            ProfileBar(),
            SizedBox(height: 50),
            Expanded(child: ProfileMenu()),
          ],
        ),
      ),

      // logout at bottomof screen
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer(
            builder: (context, ref, _) {
              final _auth = ref.read(authProvider);
              return InkWell(
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: ProfileMenu().menuItem(Icons.logout, 'Log Out'));
            },
          )),
    ));
  }
}
