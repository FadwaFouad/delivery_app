import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: InkWell(
          onTap: () {},
          child: CircleAvatar(
              backgroundColor: Colors.orange.shade100,
              backgroundImage: AssetImage('assets/images/profile.jpg')),
        ),
        title: Text('Welcome'),
        subtitle: Text('name'),
        trailing: Icon(
          Icons.shopping_cart,
          color: Colors.orange.shade800,
        ));
  }
}
