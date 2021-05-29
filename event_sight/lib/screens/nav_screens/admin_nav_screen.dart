import "package:flutter/material.dart";

import "../admin_home_screen.dart";
import "../member_request_screen.dart";
import "../../widgets/event_form.dart";

import "../../widgets/drawers/admin_drawer.dart";

class AdminNavScreen extends StatefulWidget {
  static const routeName = "/admin";
  final isAdmin;
  AdminNavScreen(this.isAdmin);
  @override
  _AdminNavScreenState createState() => _AdminNavScreenState();
}

class _AdminNavScreenState extends State<AdminNavScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var pages = [
      {"page": AdminHomeScreen(widget.isAdmin), "title": "Event Sight"},
      {"page": MemberRequestScreen(), "title": "Member Requests"},
      {"page": EventForm(), "title": "Add New Event"},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedIndex]["title"]),
        elevation: 0,
      ),
      endDrawer: AdminDrawer(),
      body: pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        backgroundColor: Color.fromRGBO(0, 38, 66, 1),
        selectedItemColor: Color.fromRGBO(229, 149, 0, 1),
        unselectedItemColor: Color.fromRGBO(229, 218, 218, 1),
        iconSize: 33,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: ""),
        ],
      ),
    );
  }
}
