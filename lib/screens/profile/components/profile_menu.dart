import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
            onTap: () {},
            child: menuItem(Icons.person_search_sharp, 'My Profile')),
        SizedBox(height: 10),
        // => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => AllMedicineList(),
        //     )),
        SizedBox(height: 10),
        menuItem(Icons.favorite, 'Favorites'),
        SizedBox(height: 10),
        menuItem(Icons.settings, 'Settings'),
        SizedBox(height: 10),
      ],
    );
  }

  Widget menuItem(IconData icon, String name) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          )),
      child: ListTile(
        leading: Icon(
          icon,
          color: kPrimaryColor.shade700,
        ),
        title: Text(
          name,
        ),
        trailing: Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}
