import "package:flutter/material.dart";

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  int _index = 0;
  var _userName = "";
  var _userSid = "";
  var _userEmail = "";
  var _userPassword = "";

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (BuildContext context,
          {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        return Row(
          children: [
            if (_index == 3)
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {},
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  )),
            if (_index >= 0 && _index < 3)
              FlatButton(
                  textColor: Color.fromRGBO(0, 38, 66, 1),
                  onPressed: () {
                    setState(() {
                      _index += 1;
                    });
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 20),
                  )),
            if (_index > 0 && _index <= 3)
              FlatButton(
                  textColor: Color.fromRGBO(132, 0, 50, 1),
                  onPressed: () {
                    setState(() {
                      _index -= 1;
                    });
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20),
                  )),
          ],
        );
      },
      currentStep: _index,
      steps: <Step>[
        Step(
          title: const Text('User Info'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        Step(
          title: Text('Email Info'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 2')),
        ),
        Step(
          title: Text('Profile Image'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 3')),
        ),
        Step(
          title: Text('Password'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 4')),
        )
      ],
    );
  }
}
