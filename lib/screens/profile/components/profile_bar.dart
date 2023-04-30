import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: kPrimaryColor.shade100,
          radius: 60,
          backgroundImage: AssetImage(
            "assets/images/profile.jpg",
          ),
        ),
        SizedBox(height: 5),
        Text(
          user?.displayName ?? 'name',
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              color: kPrimaryColor.shade700,
              size: 17,
            ),
            SizedBox(width: 5),
            Text(
              'ahmed@gmail.com',
            ),
          ],
        ),
      ],
    );
  }
}
