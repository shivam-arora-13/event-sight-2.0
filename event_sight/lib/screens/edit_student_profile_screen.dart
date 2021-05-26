import "package:flutter/material.dart";

class EditStudentProfile extends StatefulWidget {
  static const routeName = "/edit-student-profile";
  @override
  _EditStudentProfileState createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
