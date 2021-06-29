import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../widgets/home_screen_elements.dart";
import "./event_screen.dart";

class AdminHomeScreen extends StatefulWidget {
  static const routeName = "/admin-home";
  final isAdmin;
  AdminHomeScreen(this.isAdmin);
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var shouldLoad = false;
  var organiserId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.isAdmin) {
      organiserId = ModalRoute.of(context).settings.arguments as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("organisers")
            .doc(widget.isAdmin
                ? FirebaseAuth.instance.currentUser.uid
                : organiserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          var organiserData = snapshot.data;
          return Scaffold(
            appBar: widget.isAdmin
                ? null
                : AppBar(title: Text(organiserData["name"])),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      height: widget.isAdmin
                          ? MediaQuery.of(context).size.height * 0.22
                          : MediaQuery.of(context).size.height * 0.30,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5),
                              ClubLogo(organiserData["image_url"]),
                              SizedBox(width: 5),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClubStat(
                                        organiserData["members"]
                                            .toSet()
                                            .toList()
                                            .length,
                                        "Members"),
                                    ClubStat(
                                        organiserData["followers"]
                                            .toSet()
                                            .toList()
                                            .length,
                                        "Followers"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          ClubInfo(
                            organiserData["name"],
                            organiserData["description"],
                          ),
                          if (!widget.isAdmin)
                            ClubButtons(
                              organiserData["id"],
                              organiserData["followers"],
                              organiserData["members"],
                            ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: widget.isAdmin
                          ? MediaQuery.of(context).size.height * 0.55
                          : MediaQuery.of(context).size.height * 0.50,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("events")
                              .where("organiser",
                                  isEqualTo: widget.isAdmin
                                      ? FirebaseAuth.instance.currentUser.uid
                                      : organiserId)
                              .snapshots(),
                          builder: (ctx, eventsSnapshot) {
                            if (eventsSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            var events =
                                eventsSnapshot.data.docs as List<dynamic>;

                            if (events.isEmpty) {
                              return Center(child: Text("No events to show"));
                            }
                            return GridView(
                                children: events.map((event) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          EventScreen.routeName,
                                          arguments: event.id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      width: 100,
                                      height: 100,
                                      child: Image.network(event["poster_url"]),
                                    ),
                                  );
                                }).toList(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5));
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
