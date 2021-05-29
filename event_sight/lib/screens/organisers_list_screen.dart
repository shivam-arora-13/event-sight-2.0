import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "../widgets/organiser_tile.dart";
import "./admin_home_screen.dart";

class OrganisersListScreen extends StatefulWidget {
  static const routeName = "/organisers-list-screen";
  @override
  _OrganisersListScreenState createState() => _OrganisersListScreenState();
}

class _OrganisersListScreenState extends State<OrganisersListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("organisers").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
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
                child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white)),
              ),
            );
          }
          var organisersData = snapshot.data.docs as List<dynamic>;

          return Scaffold(
            appBar: AppBar(
              title: Text("Organisers"),
              elevation: 0,
            ),
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
                  children: organisersData.map((organiser) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AdminHomeScreen.routeName,
                        arguments: organiser["id"]);
                  },
                  child: OrganiserTile(
                    organiser["name"],
                    organiser["description"],
                    organiser["image_url"],
                    organiser["followers"].length,
                    organiser["members"].length,
                  ),
                );
              }).toList()),
            ),
          );
        });
  }
}
