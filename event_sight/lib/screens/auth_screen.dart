import "package:flutter/material.dart";
import "../widgets/login_form.dart";

import "package:firebase_auth/firebase_auth.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _onSubmit(String email, String password, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (err) {
      var message = "Login Failed";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    }
    setState(() {
      _isLoading = false;
    });
  }

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
            LoginForm(_onSubmit, _isLoading)
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
