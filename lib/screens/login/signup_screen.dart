import 'package:flutter/material.dart';

import '../../constant.dart';
import 'components/helper.dart';
import 'login_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // global key for form
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  // initlize form variables
  String userName = '';
  String email = '';
  String? password = '';
  String? confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //header
                header(),
                // input form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    titleStyle('Name'),
                    nameText(),
                    SizedBox(height: 5),
                    titleStyle('Email'),
                    emailText(),
                    SizedBox(height: 5),
                    titleStyle('Password'),
                    passwordText(),
                    SizedBox(height: 5),
                    titleStyle('Confirm Password'),
                    confirmPasswordText(),
                    SizedBox(height: 30),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {},
                    // onPressed: () async {
                    //   FocusManager.instance.primaryFocus?.unfocus();
                    //   if (_formKey.currentState!.validate()) {
                    //     // conect to firebase to login
                    //     String? isSign =
                    //         await context.read<AuthProvider>().signUp(
                    //               name: userName,
                    //               email: email.trim(),
                    //               password: password!.trim(),
                    //             );

                    //     if (isSign == 'Signed') {
                    //       Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => BottomNav()));
                    //     } else {
                    //       var snackBar = SnackBar(content: Text(isSign!));
                    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //     }
                    //   }
                    // },
                    color: kPrimaryColor.shade700,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // footer
                Text("or continue with"),
                SizedBox(height: 10),
                Helper.buildSocialBtnRow(),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("already have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        " Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: kPrimaryColor),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleStyle(String label) {
    return Text(
      label,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
    );
  }

  Widget header() {
    return Column(
      children: <Widget>[
        SizedBox(height: 40),
        Image.asset(
          "assets/images/logo.png",
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.5,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 20),
        Text(
          "create new account",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade800),
        )
      ],
    );
  }

  Widget nameText() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter name';
        }
        userName = value;
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: kPrimaryColor.shade200,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400))),
    );
  }

  Widget emailText() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter email';
        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'please enter valid email';
        }
        email = value;
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: kPrimaryColor.shade200,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400))),
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: !passwordVisible,
      validator: (value) {
        password = value;
        if (value == null || value.isEmpty) {
          return 'please enter password';
        } else if (!RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value)) {
          return 'please enter strong password\n must be 8 character with one capital case,' +
              ' \n & one lower case & one digit & (@#\$!) ';
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: passwordIcon(),
          prefixIcon: Icon(
            Icons.lock,
            color: kPrimaryColor.shade200,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400))),
    );
  }

  Widget confirmPasswordText() {
    return TextFormField(
      obscureText: !passwordVisible,
      validator: (value) {
        confirmPassword = value;
        if (value == null || value.isEmpty) {
          return 'please enter password again';
        } else if (password != confirmPassword) {
          return 'Password don\'t match';
        }
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: passwordIcon(),
          prefixIcon: Icon(
            Icons.lock,
            color: kPrimaryColor.shade200,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400))),
    );
  }

  Widget passwordIcon() {
    return IconButton(
      icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(
          () {
            passwordVisible = !passwordVisible;
          },
        );
      },
    );
  }
}
