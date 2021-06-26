import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class FAB extends StatefulWidget {
  final eventId;
  FAB(this.eventId);

  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: "Register",
          iconColor: Color.fromRGBO(229, 149, 0, 1),
          bubbleColor: Theme.of(context).primaryColor,
          icon: Icons.event,
          titleStyle:
              TextStyle(fontSize: 16, color: Color.fromRGBO(229, 149, 0, 1)),
          onPress: registerEvent
          //_animationController.reverse();
          ,
        ),
        // Floating action menu item
        Bubble(
          title: "Interested",
          iconColor: Color.fromRGBO(229, 149, 0, 1),
          bubbleColor: Theme.of(context).primaryColor,
          icon: Icons.bookmark_border,
          titleStyle:
              TextStyle(fontSize: 16, color: Color.fromRGBO(229, 149, 0, 1)),
          onPress: markInterested
          // _animationController.reverse();
          ,
        ),
        //Floating action menu item
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),

      // Floating Action button Icon color
      iconColor: Theme.of(context).primaryColor,

      // Flaoting Action button Icon
      iconData: Icons.ac_unit,
      backGroundColor: Color.fromRGBO(229, 149, 0, 1),
    );
  }
}
