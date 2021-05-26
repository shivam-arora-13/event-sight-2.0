import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class SignupForm extends StatefulWidget {
  final _submitForm;
  final bool _isLoading;
  SignupForm(this._submitForm, this._isLoading);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  var showPassword = false;
  var showConfirmPassword = false;
  String _sid = "";
  String _name = "";
  String _email = "";
  String _password = "";
  String confirmPassword = "";
  File _userImage;
  void receiveImage(File image) {
    _userImage = image;
  }

  void _trySubmit() {
    if (_userImage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          content: Text("Select a Display picture")));
      return;
    }
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid && _userImage != null) {
      widget._submitForm(
        _email.trim(),
        _password.trim(),
        _name.trim(),
        _sid.trim(),
        _userImage,
        context,
      );
    }
  }

  final sidController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.white70,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: 10,
                  right: MediaQuery.of(context).size.width * 0.1,
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: sidController,
                        onChanged: (value) {
                          _sid = value;
                        },
                        validator: (value) {
                          if (value.trim().length != 8) {
                            return "Enter a valid SID";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'SID',
                          prefixIcon: Icon(Icons.fingerprint_outlined),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        onChanged: (value) {
                          _name = value;
                        },
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return "Enter your Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return "Enter your Email Address";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: !showPassword,
                        controller: passwordController,
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value.trim().length < 8) {
                            return "minimum length : 8 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
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
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        validator: (value) {
                          if (value != _password) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        obscureText: !showConfirmPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showConfirmPassword = !showConfirmPassword;
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: showConfirmPassword
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              )),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(height: 10),
                      widget._isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Color.fromRGBO(229, 149, 0, 1),
                            )
                          : Container(
                              width: double.infinity,
                              child: RaisedButton(
                                child: Text("Submit"),
                                color: Color.fromRGBO(229, 149, 0, 1),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30)),
                                onPressed: _trySubmit,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              Positioned(top: -30, child: DisplayPicturePicker(receiveImage)),
            ],
          ),
        ),
      ],
    );
  }
}

class DisplayPicturePicker extends StatefulWidget {
  final Function _submitImage;
  DisplayPicturePicker(this._submitImage);
  @override
  _DisplayPicturePickerState createState() => _DisplayPicturePickerState();
}

class _DisplayPicturePickerState extends State<DisplayPicturePicker> {
  File pickedImage;

  void _selectImage(String src) async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
        source: src == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    if (imageFile == null) {
      return;
    }

    setState(() {
      pickedImage = File(imageFile.path);
    });
    widget._submitImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color.fromRGBO(229, 149, 0, 1),
            child: pickedImage == null
                ? Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  )
                : null,
            backgroundImage:
                pickedImage == null ? null : FileImage(pickedImage),
          ),
          FlatButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Center(child: Text("Choose Image Source")),
                        actions: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pop("Camera");
                                        },
                                        label: Text("Camera"),
                                        icon: Icon(Icons.camera_alt)),
                                    FlatButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pop("Gallery");
                                        },
                                        label: Text("Gallery"),
                                        icon: Icon(Icons.folder)),
                                  ],
                                ),
                              ),
                              FlatButton(
                                textColor: Colors.red,
                                onPressed: () {
                                  Navigator.of(context).pop("Cancel");
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).then((mode) {
                  if (mode == "Cancel") {
                    return;
                  } else {
                    _selectImage(mode);
                  }
                });
              },
              icon: Icon(Icons.camera_alt),
              label: Text(pickedImage == null
                  ? "Pick Profile Image"
                  : "Change Profile Image"))
        ],
      ),
    );
  }
}
