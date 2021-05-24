import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text("Submit"),
                          color: Color.fromRGBO(229, 149, 0, 1),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(top: -30, child: DisplayPicturePicker()),
            ],
          ),
        ),
      ],
    );
  }
}

class DisplayPicturePicker extends StatefulWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
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
