import "package:flutter/material.dart";

import "../widgets/event_info.dart";

class EventScreen extends StatefulWidget {
  static const routeName = "/event";
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Event Name"),
          actions: [
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info), text: "Info"),
              Tab(icon: Icon(Icons.event), text: "Registered Students"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventInfo(),
            Center(child: Text("Registered Students")),
          ],
        ),
      ),
    );
  }
}
