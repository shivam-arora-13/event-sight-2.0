import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../widgets/student_profile_components.dart";

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final _auth = FirebaseAuth.instance;
  var userData = null;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("students")
            .where("id", isEqualTo: _auth.currentUser.uid)
            .get(),
        builder: (context, userSnapshot) {
          if (userSnapshot.data != null) {
            userData = userSnapshot.data.docs[0];
          }

          return userSnapshot.connectionState != ConnectionState.done
              ? Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          UserProfilePicture(userData["image_url"]),
                          SizedBox(height: 10),
                          Divider(),
                          InfoTile(userData["name"], Icons.person),
                          Divider(),
                          InfoTile(userData["sid"], Icons.info),
                          Divider(),
                          InfoTile(userData["email"], Icons.email),
                          Divider(),
                          SizedBox(height: 20),
                          UserClubs(),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}

class UserClubs extends StatefulWidget {
  @override
  _UserClubsState createState() => _UserClubsState();
}

class _UserClubsState extends State<UserClubs> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 130,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Text(
                    "Member At",
                    style: TextStyle(
                        decoration:
                            _index == 0 ? TextDecoration.underline : null,
                        fontSize: 18,
                        color: _index == 0
                            ? Color.fromRGBO(0, 38, 66, 1)
                            : Colors.grey),
                  )),
            ),
            Container(
              width: 0.5,
              height: 30,
              color: Colors.grey,
            ),
            SizedBox(
              width: 130,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Text(
                    "Follows",
                    style: TextStyle(
                        decoration:
                            _index == 1 ? TextDecoration.underline : null,
                        fontSize: 18,
                        color: _index == 1
                            ? Color.fromRGBO(0, 38, 66, 1)
                            : Colors.grey),
                  )),
            ),
          ],
        ),
        Divider(
          height: 10,
          color: Colors.black,
        ),
        if (_index == 0) ClubLists("members"),
        if (_index == 1) ClubLists("followers"),
      ],
    );
  }
}

class UserProfilePicture extends StatelessWidget {
  final imgUrl;
  UserProfilePicture(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 105,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 38, 66, 1),
              Color.fromRGBO(132, 0, 50, 1),
              Color.fromRGBO(229, 149, 0, 1),
            ],
          )),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(imgUrl),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
