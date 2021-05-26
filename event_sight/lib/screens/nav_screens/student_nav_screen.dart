import "package:flutter/material.dart";
import "package:badges/badges.dart";

import '../student_home_screen.dart';
import '../student_profile.dart';
import "../../widgets/notifications.dart";
import '../../widgets/drawers/student_drawer.dart';

class StudentNavScreen extends StatefulWidget {
  static const routeName = "/student-nav-screen";
  @override
  _StudentNavScreenState createState() => _StudentNavScreenState();
}

class _StudentNavScreenState extends State<StudentNavScreen> {
  int _selectedIndex = 0;
  final _pages = [
    {"page": StudentHomeScreen(), "title": "Event Sight"},
    {"page": StudentHomeScreen(), "title": ""},
    {"page": StudentHomeScreen(), "title": ""},
    {"page": Notifications(), "title": ""},
    {"page": StudentProfile(), "title": "User Profile"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]["title"]),
      ),
      endDrawer: StudentDrawer(),
      body: _pages[_selectedIndex]["page"],
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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
          BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Color.fromRGBO(132, 0, 50, 1),
                badgeContent: Text(
                  "10",
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.notifications),
              ),
              label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
        ],
      ),
    );
  }
}
