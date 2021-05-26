import "package:flutter/material.dart";
import "../screens/signup_screen.dart";

class LoginForm extends StatefulWidget {
  final _isLoading;
  final _onSubmit;
  LoginForm(this._onSubmit, this._isLoading);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._onSubmit(
        email.trim(),
        password.trim(),
        context,
      );
    }
  }

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
              onChanged: (value) {
                email = value;
              },
              controller: emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Enter email address";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              controller: passwordController,
              validator: (value) {
                if (value.length < 8) {
                  return "minimum length : 8 characters";
                }
                return null;
              },
              obscureText: !showPassword,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        Icons.remove_red_eye_outlined,
                        color: showPassword
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      )),
                  labelText: "Password",
                  prefixIcon: Icon(Icons.vpn_key)),
            ),
            SizedBox(height: 20),
            widget._isLoading
                ? CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(229, 149, 0, 1),
                  )
                : SizedBox(
                    width: 120,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)),
                      onPressed: _trySubmit,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ),
                  ),
            //Add Option for admin login
            if (!widget._isLoading)
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
