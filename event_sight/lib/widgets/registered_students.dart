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
        var studentIds = [];
        registeredDetails.forEach((element) {
          studentIds.add(element["student"]);
        });
        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("students")
              .where("id", whereIn: studentIds)
              .get(),
          builder: (ctx1, studentSnapshot) {
            if (studentSnapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            var students = studentSnapshot.data.docs as List<dynamic>;
            return ListView.builder(
              itemBuilder: (ctx2, i) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(students[i]["image_url"])),
                  title: Text(students[i]["name"]),
                  subtitle: Text(students[i]["sid"]),
                );
              },
              itemCount: students.length,
            );
          },
        );
      },
    );
  }
}
