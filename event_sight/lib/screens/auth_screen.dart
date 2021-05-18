import "package:flutter/material.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Event Sight",
            style: TextStyle(
                fontFamily: "EBGaramond",
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.w600),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 38, 66, 1),
                Color.fromRGBO(132, 0, 50, 1)
              ]),
        ),
      ),
    );
  }
}
