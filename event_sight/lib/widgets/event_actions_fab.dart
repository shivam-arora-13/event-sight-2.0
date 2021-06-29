import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/rendering.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FAB extends StatefulWidget {
  final eventId;
  FAB(this.eventId);

  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> with TickerProviderStateMixin {
  ScrollController scrollController;
  bool dialVisible = true;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  void markInterested() async {
    try {
      final res = await FirebaseFirestore.instance
          .collection("events")
          .doc(widget.eventId)
          .get();
      final event = res.data();

      await FirebaseFirestore.instance.collection("interested").add({
        "student": FirebaseAuth.instance.currentUser.uid,
        "event": widget.eventId,
        "event_name": event["title"],
        "event_date": event["date"]
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Marked Interested"),
        backgroundColor: Colors.green,
      ));
    } catch (err) {
      var message = "Error occured";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  void registerEvent() async {
    print("hello");
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm registration"),
            content: Text("Do you want to register in the event ?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  textColor: Colors.green,
                  child: Text("Confirm")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  textColor: Colors.red,
                  child: Text("Cancel")),
            ],
          );
        }).then((confirm) async {
      print(confirm);
      if (confirm) {
        //write code here
        try {
          final res = await FirebaseFirestore.instance
              .collection("events")
              .doc(widget.eventId)
              .get();
          final event = res.data();
          await FirebaseFirestore.instance.collection("registered").add({
            "student": FirebaseAuth.instance.currentUser.uid,
            "event": widget.eventId,
            "event_name": event["title"],
            "event_date": event["date"]
          });
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text("Registered"),
            backgroundColor: Colors.green,
          ));
        } catch (err) {
          var message = "Error occured";
          if (err.message != null) {
            message = err.message;
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      }
    });
  }

  void markUninterested(id) async {
    try {
      await FirebaseFirestore.instance
          .collection("interested")
          .doc(id)
          .delete();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Removed from Interested"),
        backgroundColor: Colors.red,
      ));
    } catch (err) {
      var message = "Error occured";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  void UnregisterEvent(id) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Cancel Registration ? "),
            content: Text("Do you want to unregister from the event ?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  textColor: Colors.green,
                  child: Text("Confirm")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  textColor: Colors.red,
                  child: Text("Cancel")),
            ],
          );
        }).then((confirm) async {
      print(confirm);
      if (confirm) {
        //write code here
        try {
          await FirebaseFirestore.instance
              .collection("registered")
              .doc(id)
              .delete();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text("Unregistered"),
            backgroundColor: Colors.red,
          ));
        } catch (err) {
          var message = "Error occured";
          if (err.message != null) {
            message = err.message;
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.ac_unit,
      activeIcon: Icons.remove,

      buttonSize: 56.0,
      visible: true,

      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Theme.of(context).primaryColor,
      overlayOpacity: 0.5,

      backgroundColor: Color.fromRGBO(229, 149, 0, 1),
      elevation: 8.0,
      shape: CircleBorder(),
      gradientBoxShape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(229, 149, 0, 1),
          Color.fromRGBO(229, 149, 0, 1),
        ],
      ),
      children: [
        SpeedDialChild(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("interested")
                .where("event", isEqualTo: widget.eventId)
                .where("student",
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return IconButton(
                    onPressed: markInterested,
                    icon: Icon(
                      Icons.bookmark_outline,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ));
              }
              if ((snapshot.data.docs as List<dynamic>).isNotEmpty) {
                print((snapshot.data.docs as List<dynamic>).length);
                return IconButton(
                    onPressed: () {
                      markUninterested(
                          (snapshot.data.docs as List<dynamic>)[0].id);
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ));
              }
              return IconButton(
                  onPressed: markInterested,
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Color.fromRGBO(229, 149, 0, 1),
                  ));
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        SpeedDialChild(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("registered")
                .where("event", isEqualTo: widget.eventId)
                .where("student",
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return IconButton(
                    onPressed: registerEvent,
                    icon: Icon(
                      Icons.event,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ));
              }
              if ((snapshot.data.docs as List<dynamic>).isNotEmpty) {
                print((snapshot.data.docs as List<dynamic>).length);
                return IconButton(
                    onPressed: () {
                      UnregisterEvent(
                          (snapshot.data.docs as List<dynamic>)[0].id);
                    },
                    icon: Icon(
                      Icons.event_available,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ));
              }
              return IconButton(
                  onPressed: registerEvent,
                  icon: Icon(
                    Icons.event,
                    color: Color.fromRGBO(229, 149, 0, 1),
                  ));
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ],
    );
    ;
  }
}
