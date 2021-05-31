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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
          child: Column(
        children: [
          TopBar(),
          SizedBox(height: 5),
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: EventsLoader()),
        ],
      )),
    );
  }
}

class EventsLoader extends StatefulWidget {
  @override
  _EventsLoaderState createState() => _EventsLoaderState();
}

class _EventsLoaderState extends State<EventsLoader> {
  var events = <dynamic>{};

  Future setEvents() async {
    events = <dynamic>{};
    var organisers = [];
    var followersEvents;
    var memberEvents;
    //members only
    final res = await FirebaseFirestore.instance
        .collection("organisers")
        .where("members", arrayContains: FirebaseAuth.instance.currentUser.uid)
        .get();
    if (res.docs.isNotEmpty) {
      (res.docs as List<dynamic>).forEach((element) {
        organisers.add(element.id);
      });
    }
    if (organisers.isNotEmpty) {
      memberEvents = await FirebaseFirestore.instance
          .collection("events")
          .where("organiser", whereIn: organisers)
          .where("open_to_all", isEqualTo: false)
          .get();
      (memberEvents.docs as List<dynamic>).forEach((element) {
        events.add(element);
      });
    }
    //followers only
    organisers = [];

    final res2 = await FirebaseFirestore.instance
        .collection("organisers")
        .where("followers",
            arrayContains: FirebaseAuth.instance.currentUser.uid)
        .get();
    if (res2.docs.isNotEmpty) {
      (res2.docs as List<dynamic>).forEach((element) {
        organisers.add(element.id);
      });
    }
    if (organisers.isNotEmpty) {
      followersEvents = await FirebaseFirestore.instance
          .collection("events")
          .where("organiser", whereIn: organisers)
          .where("open_to_all", isEqualTo: true)
          .get();
      (followersEvents.docs as List<dynamic>).forEach((element) {
        events.add(element);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setEvents(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()]);
          }
          return SingleChildScrollView(
            child: events.isEmpty
                ? Text("No Events to show")
                : Column(
                    children: events.toList().map((event) {
                    return EventCard(event);
                  }).toList()),
          );
        });
  }
}
