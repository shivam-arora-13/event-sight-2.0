import "dart:io";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:cloud_firestore/cloud_firestore.dart";

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
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _onSignupSubmit(
    String email,
    String password,
    String name,
    String sid,
    File image,
    BuildContext ctx,
  ) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential userCredential;

    try {
      //check if sid exists
      await FirebaseFirestore.instance
          .collection("students")
          .doc(sid)
          .get()
          .then((res) {
        if (res.exists) {
          throw FormatException("SID Already exists");
        }
      });
      //Firebase authentication
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //store image on cloud
      final ref = FirebaseStorage.instance
          .ref()
          .child("student_profile_images")
          .child(sid + ".jpg");

      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      //store user data in firestore
      await FirebaseFirestore.instance.collection("students").doc(sid).set({
        "name": name,
        "email": email,
        "sid": sid,
        "image_url": url,
        "id": userCredential.user.uid
      });
      //save role
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("role", "student");

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } catch (err) {
      var message = "An error occured, please check your credentials";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Theme.of(ctx).errorColor, content: Text(message)));
    }
    setState(() {
      _isLoading = false;
    });
  }

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
          child: Center(
              child: SingleChildScrollView(
                  child: SignupForm(_onSignupSubmit, _isLoading))),
        ));
  }
}
