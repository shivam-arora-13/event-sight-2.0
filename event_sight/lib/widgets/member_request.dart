import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

import "../screens/student_profile.dart";

class MemberRequest extends StatefulWidget {
  final imgUrl;
  final name;
  final sid;
  final email;
  final id;
  MemberRequest({
    @required this.imgUrl,
    @required this.name,
    @required this.sid,
    @required this.email,
    @required this.id,
  });

  @override
  _MemberRequestState createState() => _MemberRequestState();
}

class _MemberRequestState extends State<MemberRequest> {
  var isLoading = false;
  void acceptMemberRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      //code to add member and follower
      var organiserData = await FirebaseFirestore.instance
          .collection("organisers")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      var followers = [...organiserData["followers"], widget.id];
      var members = [...organiserData["members"], widget.id];
      print(followers);
      await FirebaseFirestore.instance
          .collection("organisers")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "followers": followers,
        "members": members,
      });
      final res = await FirebaseFirestore.instance
          .collection("member_requests")
          .where("students", isEqualTo: widget.id)
          .where("organiser", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get();
      final reqId = res.docs[0].id;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Member request accepted"),
        backgroundColor: Colors.green,
      ));
      await FirebaseFirestore.instance
          .collection("member_requests")
          .doc(reqId)
          .delete();
    } catch (err) {
      var message = "Error occured";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  void rejectMemberRequest() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await FirebaseFirestore.instance
          .collection("member_requests")
          .where("students", isEqualTo: widget.id)
          .where("organiser", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get();
      final reqId = res.docs[0].id;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Member request rejected"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      await FirebaseFirestore.instance
          .collection("member_requests")
          .doc(reqId)
          .delete();
    } catch (err) {
      var message = "Error occured";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.yellow))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    UserProfilePicture(widget.imgUrl),
                    InfoTile(Icons.person, widget.name),
                    InfoTile(Icons.info, widget.sid),
                    InfoTile(Icons.email, widget.email),
                  ],
                ),
                Container(
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MemberRequestButtons(
                          acceptMemberRequest, rejectMemberRequest),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.white54,
      //add conditions for only one request
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.1,
          bottom: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.00),
    );
  }
}

class MemberRequestButtons extends StatelessWidget {
  final accept;
  final reject;
  MemberRequestButtons(this.accept, this.reject);
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: accept,
            icon: Icon(
              Icons.person_add,
              size: 40,
            ),
            color: Color.fromRGBO(0, 38, 66, 1),
          ),
          VerticalDivider(
            width: 10,
            indent: 70,
          ),
          IconButton(
            onPressed: reject,
            icon: Icon(
              Icons.cancel_outlined,
              size: 40,
            ),
            color: Color.fromRGBO(132, 0, 50, 1),
          ),
        ]);
  }
}

class InfoTile extends StatelessWidget {
  final icon;
  final String info;
  InfoTile(this.icon, this.info);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 25,
            color: Color.fromRGBO(0, 38, 66, 1),
          ),
          title: Container(
            height: 20,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: FittedBox(
                child: Text(
              info,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )),
          ),
        ),
        Divider(),
      ],
    );
  }
}
