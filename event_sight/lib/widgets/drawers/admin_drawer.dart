import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:firebase_auth/firebase_auth.dart";

class AdminDrawer extends StatelessWidget {
  void confirmLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm Logout"),
            content: Text("Do you want to log out of your account?"),
            actions: [
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Confirm")),
              FlatButton(
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel")),
            ],
          );
        }).then((value) async {
      if (value) {
        await FirebaseAuth.instance.signOut();
        final prefs = await SharedPreferences.getInstance();
        prefs.remove("role");
      }
    });
  }

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
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              confirmLogout(context);
            },
          ),
        ],
      ),
    );
  }
}
