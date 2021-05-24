import "package:flutter/material.dart";

import "../widgets/signup_form.dart";

class SignUpScreen extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final appBar = AppBar(
    title: Text("New User Signup"),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: Container(
          height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color.fromRGBO(0, 38, 66, 1),
                  Color.fromRGBO(0, 38, 66, 1)
                ]),
          ),
          child: Center(child: SingleChildScrollView(child: SignupForm())),
        ));
  }
}
