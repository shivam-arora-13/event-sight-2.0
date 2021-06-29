import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../screens/event_screen.dart";
import "./comment_section.dart";

class EventCard extends StatefulWidget {
  final event;
  EventCard(this.event);
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  var _isExpanded = false;
  void markInterested() async {
    try {
      await FirebaseFirestore.instance.collection("interested").add({
        "student": FirebaseAuth.instance.currentUser.uid,
        "event": widget.event.id,
        "event_name": widget.event["title"],
        "event_date": widget.event["date"]
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

  void registerEvent() async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm registration"),
            content: Text(
                "Do you want to register in the event ${widget.event["title"]} ?"),
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
          await FirebaseFirestore.instance.collection("registered").add({
            "student": FirebaseAuth.instance.currentUser.uid,
            "event": widget.event.id,
            "event_name": widget.event["title"],
            "event_date": widget.event["date"]
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

  void UnregisterEvent(id) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Cancel Registration ? "),
            content: Text(
                "Do you want to unregister from the event ${widget.event["title"]} ?"),
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
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                  Colors.black,
                ])),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.event["organiser_img"]),
              ),
              trailing: !widget.event["open_to_all"]
                  ? Icon(
                      Icons.verified_user,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    )
                  : null,
              title: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                      child: Text(
                    widget.event["title"].length > 30
                        ? widget.event["title"].substring(0, 30) + "..."
                        : widget.event["title"],
                    style: TextStyle(
                      //fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(229, 149, 0, 1),
                    ),
                  ))),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor)),
            height: 500,
            width: MediaQuery.of(context).size.width - 10,
            child:
                Image.network(widget.event["poster_url"], fit: BoxFit.contain),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                  Colors.black,
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("registered")
                            .where("event", isEqualTo: widget.event.id)
                            .where("student",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return IconButton(
                                icon: Icon(
                                  Icons.event,
                                  size: 27,
                                  color: Color.fromRGBO(229, 149, 0, 1),
                                ),
                                onPressed: registerEvent);
                          }
                          if ((snapshot.data.docs as List<dynamic>)
                              .isNotEmpty) {
                            return IconButton(
                                icon: Icon(
                                  Icons.event_available,
                                  size: 27,
                                  color: Color.fromRGBO(229, 149, 0, 1),
                                ),
                                onPressed: () {
                                  UnregisterEvent(
                                      (snapshot.data.docs as List<dynamic>)[0]
                                          .id);
                                });
                          }
                          return IconButton(
                              icon: Icon(
                                Icons.event,
                                size: 27,
                                color: Color.fromRGBO(229, 149, 0, 1),
                              ),
                              onPressed: registerEvent);
                        }),
                    IconButton(
                        icon: Icon(
                          _isExpanded ? Icons.comment : Icons.comment_outlined,
                          size: 27,
                          color: Color.fromRGBO(229, 149, 0, 1),
                        ),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.info_outline,
                          size: 27,
                          color: Color.fromRGBO(229, 149, 0, 1),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(EventScreen.routeName,
                              arguments: widget.event.id);
                        }),
                  ],
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("interested")
                        .where("event", isEqualTo: widget.event.id)
                        .where("student",
                            isEqualTo: FirebaseAuth.instance.currentUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return IconButton(
                            icon: Icon(
                              Icons.bookmark_border,
                              size: 30,
                              color: Color.fromRGBO(229, 149, 0, 1),
                            ),
                            onPressed: markInterested);
                      }
                      if ((snapshot.data.docs as List<dynamic>).isNotEmpty) {
                        return IconButton(
                            icon: Icon(
                              Icons.bookmark,
                              size: 27,
                              color: Color.fromRGBO(229, 149, 0, 1),
                            ),
                            onPressed: () {
                              markUninterested(
                                  (snapshot.data.docs as List<dynamic>)[0].id);
                            });
                      }
                      return IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            size: 30,
                            color: Color.fromRGBO(229, 149, 0, 1),
                          ),
                          onPressed: markInterested);
                    })
              ],
            ),
          ),
          if (_isExpanded)
            AnimatedContainer(
                height: _isExpanded ? 60 : 0,
                duration: Duration(milliseconds: 500),
                child: AddComment(false, widget.event.id)),
          Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
