import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class RegisteredStudents extends StatefulWidget {
  final String eventId;
  RegisteredStudents(this.eventId);
  @override
  _RegisteredStudentsState createState() => _RegisteredStudentsState();
}

class _RegisteredStudentsState extends State<RegisteredStudents> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("registered")
          .where("event", isEqualTo: widget.eventId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var registeredDetails = snapshot.data.docs as List<dynamic>;
        if (registeredDetails.isEmpty) {
          return Center(child: Text("No Registered Students"));
        }
        return Container(
          child: Text("Hello"),
        );
      },
    );
  }
}
