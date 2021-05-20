import "package:flutter/material.dart";
import "../screens/signup_screen.dart";

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var loginCreds = {"email": "", "password": ""};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white70),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password", prefixIcon: Icon(Icons.vpn_key)),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 120,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () {},
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
                color: Color.fromRGBO(229, 149, 0, 1),
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    SizedBox(width: 5),
                    Text(
                      "SignUp",
                      style: TextStyle(color: Color.fromRGBO(132, 0, 50, 1)),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
