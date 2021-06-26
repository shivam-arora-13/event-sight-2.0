import "package:flutter/material.dart";

import "../widgets/event_info.dart";
import "../widgets/registered_students.dart";
import "./../widgets/event_actions_fab.dart";

class EventScreen extends StatefulWidget {
  static const routeName = "/event";
  final isAdmin;
  EventScreen(this.isAdmin);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var eventId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventId = ModalRoute.of(context).settings.arguments as String;
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
                  IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: Icon(Icons.delete), onPressed: () {}),
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
        body: widget.isAdmin
            ? TabBarView(
                children: [
                  EventInfo(eventId, widget.isAdmin),
                  RegisteredStudents(eventId),
                ],
              )
            : EventInfo(eventId, widget.isAdmin),
      ),
    );
  }
}
