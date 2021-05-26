import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../widgets/login_form.dart";
import "../widgets/admin_login_form.dart";

import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isAdmin = false;
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
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("role", "student");
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

  void _onAdminSubmit(String name, String password, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      final clubData = await FirebaseFirestore.instance
          .collection("organisers")
          .where("name", isEqualTo: name)
          .get();
      if (clubData.docs.isEmpty) {
        throw FormatException("Organiser does not exists");
      }
      userCredential = await _auth.signInWithEmailAndPassword(
          email: clubData.docs[0]["email"], password: password);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("role", "admin");
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
            _isAdmin
                ? AdminLoginForm(_onAdminSubmit, _isLoading)
                : LoginForm(_onSubmit, _isLoading),
            if (!_isLoading)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white70,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Admin Login ?",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(0, 38, 66, 1),
                      ),
                    ),
                    Switch(
                        activeColor: Color.fromRGBO(229, 149, 0, 1),
                        value: _isAdmin,
                        onChanged: (value) {
                          setState(() {
                            _isAdmin = value;
                          });
                        })
                  ],
                ),
              )
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
