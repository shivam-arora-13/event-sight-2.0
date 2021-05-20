import "package:flutter/material.dart";
import "../widgets/login_form.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Event Sight",
                style: TextStyle(
                    fontFamily: "EBGaramond",
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: Text(
                "P E C",
                style: TextStyle(
                  fontFamily: "EBGaramond",
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(height: 20),
            LoginForm()
          ],
        ),
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
      ),
    );
  }
}
