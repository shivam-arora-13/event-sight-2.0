import 'package:flutter/material.dart';
import "package:flutter/services.dart";

import "./screens/auth_screen.dart";
import "./screens/signup_screen.dart";
import "./screens/event_screen.dart";
import './screens/nav_screens/student_nav_screen.dart';
import "./screens/nav_screens/admin_nav_screen.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Sight',
      //home: AuthScreen(),
      home: StudentNavScreen(),
      //home: AdminNavScreen(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 38, 66, 1),
      ),
      routes: {
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        EventScreen.routeName: (ctx) => EventScreen()
      },
    );
  }
}
