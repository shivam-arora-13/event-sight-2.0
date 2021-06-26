import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "./../screens/admin_home_screen.dart";

class InfoTile extends StatelessWidget {
  final _text;
  final _icon;
  InfoTile(this._text, this._icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _icon,
        size: 27,
        color: Color.fromRGBO(0, 38, 66, 1),
      ),
      title: Container(
        width: double.infinity,
        height: 23,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Text(
            _text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ClubLists extends StatefulWidget {
  final type;
  ClubLists(this.type);
  @override
  _ClubListsState createState() => _ClubListsState();
}

class _ClubListsState extends State<ClubLists> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("organisers")
          .where(widget.type,
              arrayContains: FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ));
        }
        var organisers = snapshot.data.docs as List<dynamic>;
        if (organisers.isEmpty) {
          return Text("No Organisers to show");
        }
        return Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(AdminHomeScreen.routeName,
                          arguments: organisers[i]["id"]);
                    },
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(organisers[i]["image_url"])),
                    title: Text(
                      organisers[i]["name"],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(organisers[i]["description"]),
                  ),
                  Divider(),
                ],
              );
            },
            itemCount: organisers.length,
          ),
        );
      },
    );
  }
}
