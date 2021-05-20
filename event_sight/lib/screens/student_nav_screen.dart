import "package:flutter/material.dart";

import "./student_home_screen.dart";

class StudentNavScreen extends StatefulWidget {
  @override
  _StudentNavScreenState createState() => _StudentNavScreenState();
}

class _StudentNavScreenState extends State<StudentNavScreen> {
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 38, 66, 1),
        title: Text("Event Sight"),
      ),
      body: StudentHomeScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
        ],
      ),
    );
  }
}
