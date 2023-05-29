import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../../providers/auth_provider.dart';

class ProfileBar extends ConsumerWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // get current user
    final user = ref.read(authProvider).currentUser;

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
              user?.email ?? '',
            ),
          ],
        ),
      ],
    );
  }
}
