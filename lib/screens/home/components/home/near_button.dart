import 'package:flutter/material.dart';

class ButtonNearst extends StatelessWidget {
  const ButtonNearst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 45,
        onPressed: () {},
        color: Colors.orange.shade300,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          'Get Nearest Restauratns',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
