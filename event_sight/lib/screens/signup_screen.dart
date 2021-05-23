import "package:flutter/material.dart";

import "../widgets/signup_form.dart";

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New User Signup"),
        ),
        body: SingleChildScrollView(child: SignupForm()));
  }
}
