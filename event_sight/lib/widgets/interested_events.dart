import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "./event_card.dart";

class InterestedEvents extends StatefulWidget {
  @override
  _InterestedEventsState createState() => _InterestedEventsState();
}

class _InterestedEventsState extends State<InterestedEvents> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("interested")
          .where("student", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var interestedEvents = snapshot.data.docs as List<dynamic>;
        if (interestedEvents.isEmpty) {
          return Center(child: Text("No Interested Events"));
        }
        var eventIds = [];
        interestedEvents.forEach((element) {
          eventIds.add(element["event_name"]);
        });
        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("events")
              .where("title", whereIn: eventIds)
              .get(),
          builder: (ctx2, eventsSnapshot) {
            if (eventsSnapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            var events = eventsSnapshot.data.docs as List<dynamic>;
            events.removeWhere((eve) {
              return ((eve["date"].substring(0, 10).compareTo(
                          DateTime.now().toIso8601String().substring(0, 10)) ==
                      -1) ||
                  ((eve["date"].substring(0, 10).compareTo(DateTime.now()
                              .toIso8601String()
                              .substring(0, 10)) ==
                          0) &&
                      (eve["time"].compareTo(TimeOfDay.now().toString()) ==
                          -1)));
            });
            if (events.isEmpty) {
              return Center(child: Text("No Interested Events"));
            }
            return ListView(
                children: events.map((event) {
              return EventCard(event);
            }).toList());
          },
        );
      },
    );
  }
}
