import "package:flutter/material.dart";

import "../widgets/student_drawer.dart";
import "../widgets/organiser_tile.dart";

class OrganisersListScreen extends StatefulWidget {
  static const routeName = "/organisers-list-screen";
  @override
  _OrganisersListScreenState createState() => _OrganisersListScreenState();
}

class _OrganisersListScreenState extends State<OrganisersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organisers"),
        elevation: 0,
      ),
      endDrawer: StudentDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 38, 66, 1),
                Color.fromRGBO(132, 0, 50, 1),
              ]),
        ),
        child: ListView(
          children: List.generate(10, (index) => OrganiserTile()),
        ),
      ),
    );
  }
}
