import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:firebase_auth/firebase_auth.dart";
import '../../screens/organisers_list_screen.dart';

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
            leading: Icon(Icons.grid_view),
            title: Text("Organisers"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrganisersListScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              final prefs = await SharedPreferences.getInstance();
              prefs.remove("role");
            },
          ),
        ],
      ),
    );
  }
}
