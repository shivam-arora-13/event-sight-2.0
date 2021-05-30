import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../widgets/top_bar.dart";
import "../widgets/event_card.dart";

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(),
          SizedBox(height: 5),
          EventsLoader(),
        ],
      ),
    );
  }
}

class EventsLoader extends StatefulWidget {
  @override
  _EventsLoaderState createState() => _EventsLoaderState();
}

class _EventsLoaderState extends State<EventsLoader> {
  var events = <dynamic>{};
  var isLoading = true;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var organisers;
  //   //members only
  //   await FirebaseFirestore.instance
  //       .collection("organisers")
  //       .where("members", arrayContains: FirebaseAuth.instance.currentUser.uid);
  //   //followers only
  // }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator()) : Container();
  }
}
