import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "../widgets/member_request.dart";

class MemberRequestScreen extends StatefulWidget {
  @override
  _MemberRequestScreenState createState() => _MemberRequestScreenState();
}

class _MemberRequestScreenState extends State<MemberRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 38, 66, 1),
                Color.fromRGBO(132, 0, 50, 1),
              ]),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("member_requests")
              .where("organiser",
                  isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow));
            }
            var requests = snapshot.data.docs as List<dynamic>;
            if (requests.isEmpty) {
              return Center(
                  child: Text(
                "No pending requests",
                style: TextStyle(color: Colors.white),
              ));
            }
            var students = [];
            requests.forEach((element) {
              students.add(element["students"]);
            });

            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("students")
                  .where("id", whereIn: students)
                  .get(),
              builder: (ctx, snapshot2) {
                if (snapshot2.connectionState != ConnectionState.done) {
                  return Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.yellow));
                }
                var memberRequests = snapshot2.data.docs as List<dynamic>;
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: memberRequests.map((mr) {
                    return MemberRequest(
                      imgUrl: mr["image_url"],
                      name: mr["name"],
                      sid: mr["sid"],
                      email: mr["email"],
                      id: mr["id"],
                    );
                  }).toList(),
                );
              },
            );
          },
        ));
  }
}
