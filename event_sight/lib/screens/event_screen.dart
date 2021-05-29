import "package:flutter/material.dart";

import "../widgets/event_info.dart";

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
    print(eventId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  EventInfo(eventId),
                  Center(child: Text("Registered Students")),
                ],
              )
            : EventInfo(eventId),
      ),
    );
  }
}
