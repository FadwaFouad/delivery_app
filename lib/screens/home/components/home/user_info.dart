import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/auth_provider.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    //  get current user
    final user = ref.read(authProvider).currentUser;
    return ListTile(
        leading: InkWell(
          onTap: () {},
          child: CircleAvatar(
              backgroundColor: Colors.orange.shade100,
              backgroundImage: AssetImage('assets/images/profile.jpg')),
        ),
        title: Text('Welcome'),
        subtitle: Text(
          user?.displayName ?? '',
        ),
        trailing: Icon(
          Icons.shopping_cart,
          color: Colors.orange.shade800,
        ));
  }
}
