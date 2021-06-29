import "package:flutter/material.dart";

class AdminLoginForm extends StatefulWidget {
  final _onSubmit;
  final _isLoading;
  AdminLoginForm(this._onSubmit, this._isLoading);
  @override
  _AdminLoginFormState createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends State<AdminLoginForm> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = "Art and Photography Club";
  var showPassword = false;
  var password = "";
  final passwordController = TextEditingController();

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._onSubmit(
        dropdownValue,
        password.trim(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white70),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButton(
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color.fromRGBO(229, 149, 0, 1),
                      ),
                      value: dropdownValue,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                      items: [
                        "Art and Photography Club",
                        "Music Club",
                        "Speakers Association & Study Circle",
                      ].map((value) {
                        return DropdownMenuItem(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width - 120,
                              height: 20,
                              child: FittedBox(child: Text(value))),
                          value: value,
                        );
                      }).toList()),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              controller: passwordController,
              validator: (value) {
                if (value.trim().length < 8) {
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
          ],
        ),
      ),
    );
  }
}
