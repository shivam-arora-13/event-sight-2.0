import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";

import "./../widgets/event_edit_form.dart";

class EventEditScreen extends StatefulWidget {
  static const routeName = "/event-edit";
  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  var eventId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventId = ModalRoute.of(context).settings.arguments as String;
    print(eventId);
  }

  var isUpdating = false;

  void confirmCancel() async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm Cancel"),
            content: Text("Do you want to return without saving?"),
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
        }).then((value) {
      if (value) {
        Navigator.of(context).pop();
      }
    });
  }

  void submitUpdate(updatedEvent) {
    print(updatedEvent);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirm Update"),
            content: Text("Do you want to update the event?"),
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
        setState(() {
          isUpdating = true;
        });
        try {
          var updateObject = {
            "title": updatedEvent["title"],
            "description": updatedEvent["description"],
            "details": updatedEvent["details"],
            "open_to_all": updatedEvent["open_to_all"]
          };
          if (updatedEvent["date_time_changed"]) {
            updateObject["date"] =
                (updatedEvent["date"] as DateTime).toIso8601String();
            updateObject["time"] = updatedEvent["time"].toString();
          }
          if (updatedEvent["new_poster"] != null) {
            final ref = FirebaseStorage.instance
                .ref()
                .child("event_posters")
                .child(updatedEvent["title"] + ".jpg");
            await ref.putFile(updatedEvent["new_poster"]);
            final url = await ref.getDownloadURL();
            updateObject["poster_url"] = url;
          }
          await FirebaseFirestore.instance
              .collection("events")
              .doc(eventId)
              .update(updateObject);
          Navigator.of(context).pop();
        } catch (err) {
          String message = "Error updating the event";
          if (err.message != null) {
            message = err.message;
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ));
          setState(() {
            isUpdating = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Event"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: confirmCancel,
            icon: Icon(Icons.cancel_sharp),
          ),
        ],
      ),
      body: isUpdating
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("events")
                  .doc(eventId)
                  .get(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                return EventEditForm(snapshot.data, submitUpdate);
              },
            ),
    );
  }
}
