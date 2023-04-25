// we will be creating a widget for text field
import 'package:flutter/material.dart';

class Helper {
  static Widget inputFile({label, icon, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.green.shade200,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400))),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  static Widget buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      child: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  static Widget buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildSocialBtn(
          () {},
          AssetImage(
            'assets/images/google.png',
          ),
        ),
        buildSocialBtn(
          () => print('Login with Google'),
          AssetImage(
            'assets/images/apple.png',
          ),
        ),
        buildSocialBtn(
          () => print('Login with Facebook'),
          AssetImage(
            'assets/images/facebook.png',
          ),
        ),
      ],
    );
  }
}
