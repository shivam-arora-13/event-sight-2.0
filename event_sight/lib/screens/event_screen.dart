import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../widgets/event_info.dart";
import "../widgets/registered_students.dart";
import "./../widgets/event_actions_fab.dart";
import "./event_edit_screen.dart";

class EventScreen extends StatefulWidget {
  static const routeName = "/event";
  final isAdmin;
  EventScreen(this.isAdmin);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var eventId;
  var isDeleting = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventId = ModalRoute.of(context).settings.arguments as String;
  }

  void deleteEvent() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm delete"),
            content: Text("Do you want to permanently delete this event?"),
            actions: [
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Confirm")),
              FlatButton(
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel")),
            ],
          );
        }).then((val) async {
      print(val);
      if (val) {
        setState(() {
          isDeleting = true;
        });
        await FirebaseFirestore.instance
            .collection("events")
            .doc(eventId)
            .delete();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: widget.isAdmin ? null : FAB(eventId),
        appBar: AppBar(
          title: Text("Event Sight"),
          actions: widget.isAdmin
              ? [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, EventEditScreen.routeName,
                            arguments: eventId);
                      }),
                  IconButton(icon: Icon(Icons.delete), onPressed: deleteEvent),
                ]
              : null,
          bottom: widget.isAdmin
              ? TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: "Info"),
                    Tab(icon: Icon(Icons.event), text: "Registered Students"),
                  ],
                )
              : null,
        ),
        body: isDeleting
            ? Center(child: CircularProgressIndicator())
            : (widget.isAdmin
                ? TabBarView(
                    children: [
                      EventInfo(eventId, widget.isAdmin),
                      RegisteredStudents(eventId),
                    ],
                  )
                : EventInfo(eventId, widget.isAdmin)),
      ),
    );
  }
}
