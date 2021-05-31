import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "./event_card.dart";

class RegisteredEvents extends StatefulWidget {
  @override
  _RegisteredEventsState createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("registered")
          .where("student", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        var registeredEvents = snapshot.data.docs as List<dynamic>;
        if (registeredEvents.isEmpty) {
          return Center(child: Text("No Registered Events"));
        }
        var eventIds = [];
        registeredEvents.forEach((element) {
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
