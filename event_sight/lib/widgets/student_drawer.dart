import "package:flutter/material.dart";

import "package:firebase_auth/firebase_auth.dart";

import "../screens/nav_screens/student_nav_screen.dart";
import "../screens/organisers_list_screen.dart";

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(StudentNavScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.grid_view),
            title: Text("Organisers"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrganisersListScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
