import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:firebase_auth/firebase_auth.dart';

import "./screens/auth_screen.dart";
import "./screens/signup_screen.dart";
import "./screens/event_screen.dart";
import './screens/nav_screens/student_nav_screen.dart';
import "./screens/nav_screens/admin_nav_screen.dart";
import "./screens/organisers_list_screen.dart";
import "./screens/edit_student_profile_screen.dart";
import "./screens/admin_home_screen.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    bool isAdmin;
    return FutureBuilder(
      future: _initialization,
      builder: (ctx, appSnapshot) => MaterialApp(
        title: 'Event Sight',
        home: appSnapshot.connectionState != ConnectionState.done
            ? Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapShot) {
                  if (userSnapShot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (userSnapShot.hasData) {
                    //return StudentNavScreen();
                    return FutureBuilder(
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            isAdmin =
                                !(snapshot.data.getString("role") == "student");
                            return snapshot.data.getString("role") == "student"
                                ? StudentNavScreen()
                                : AdminNavScreen(isAdmin);
                          } else {
                            return Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                        future: SharedPreferences.getInstance());
                  } else {
                    return AuthScreen();
                  }
                }),
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 38, 66, 1),
        ),
        routes: {
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          EventScreen.routeName: (ctx) => EventScreen(isAdmin),
          StudentNavScreen.routeName: (ctx) => StudentNavScreen(),
          OrganisersListScreen.routeName: (ctx) => OrganisersListScreen(),
          EditStudentProfile.routeName: (ctx) => EditStudentProfile(),
          AdminNavScreen.routeName: (ctx) => AdminNavScreen(isAdmin),
          AdminHomeScreen.routeName: (ctx) => AdminHomeScreen(isAdmin)
        },
      ),
    );
  }
}
