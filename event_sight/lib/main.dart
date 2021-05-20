import 'package:flutter/material.dart';
import "package:flutter/services.dart";

import "./screens/auth_screen.dart";
import './screens/nav_screens/student_nav_screen.dart';
import "./screens/signup_screen.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Sight',
      // home: AuthScreen(),
      routes: {
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
      },
      home: StudentNavScreen(),
    );
  }
}
