import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../screens/admin_home_screen.dart";

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black12,
        margin: EdgeInsets.all(5),
        height: 90,
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("organisers")
              .where("followers",
                  arrayContains: FirebaseAuth.instance.currentUser.uid)
              .get(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(229, 149, 0, 1),
              ));
            }
            var organisers = snapshot.data.docs as List<dynamic>;
            if (organisers.isEmpty) {
              return Center(child: Text("Not following any Organiser"));
            }
            return ListView(
              scrollDirection: Axis.horizontal,
              children: organisers.map((organiser) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AdminHomeScreen.routeName,
                          arguments: organiser["id"]);
                    },
                    child: TopBarItem(organiser["image_url"]));
              }).toList(),
            );
          },
        ));
  }
}

class TopBarItem extends StatelessWidget {
  final imgUrl;
  TopBarItem(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 38, 66, 1),
              Color.fromRGBO(132, 0, 50, 1),
              Color.fromRGBO(229, 149, 0, 1),
            ],
          )),
      child: Container(
        height: 74,
        width: 74,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
