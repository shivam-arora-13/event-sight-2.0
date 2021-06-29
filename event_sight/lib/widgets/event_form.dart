import "dart:io";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:firebase_auth/firebase_auth.dart";

import "package:flutter/material.dart";
import "./event_form_components.dart";
import "../screens/nav_screens/admin_nav_screen.dart";

enum EventType { General, MemberSpecific }

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  int _index = 0;
  bool loading = false;
  EventType _type = EventType.General;
  final _formKey = GlobalKey<FormState>();
  var title = "";
  var description = "";
  var details = "";
  var date;
  var time;
  File eventPoster;
  bool open_to_all = true;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final detailsController = TextEditingController();

  void _submitImage(File image) {
    eventPoster = image;
  }

  void _submitDateTime(pickedDate, pickedTime) {
    date = pickedDate;
    time = pickedTime;
  }

  void _submitEvent() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Complete event form"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (eventPoster == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Choose a poster"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (date == null || time == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Choose Date/Time"),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    //alert
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Create Event ?"),
            content: Text("Do you want to create the event ${title} ?"),
            actions: [
              FlatButton(
                  textColor: Colors.green,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Create")),
              FlatButton(
                  textColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel")),
            ],
          );
        }).then((op) async {
      if (op) {
        setState(() {
          loading = true;
        });
        try {
          final ref = FirebaseStorage.instance
              .ref()
              .child("event_posters")
              .child(title + date.toString() + ".jpg");
          await ref.putFile(eventPoster);
          final url = await ref.getDownloadURL();
          final organiser = await FirebaseFirestore.instance
              .collection("organisers")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .get();
          await FirebaseFirestore.instance.collection("events").add({
            "title": title,
            "description": description,
            "details": details,
            "open_to_all": open_to_all,
            "poster_url": url,
            "date": (date as DateTime).toIso8601String(),
            "time": (time as TimeOfDay).toString(),
            "organiser": FirebaseAuth.instance.currentUser.uid,
            "doc": Timestamp.now(),
            "organiser_name": organiser["name"],
            "organiser_img": organiser["image_url"],
          });
          setState(() {
            loading = false;
          });
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Event created successfully"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("back")),
                  ],
                );
              });
        } catch (err) {
          String message = "Error creating the event";
          if (err.message != null) {
            message = err.message;
          }
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ));
        }
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: Stepper(
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: [
                    if (_index == 3)
                      FlatButton(
                          textColor: Colors.green,
                          onPressed: _submitEvent,
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 17),
                          )),
                    if (_index >= 0 && _index < 3)
                      FlatButton(
                          textColor: Color.fromRGBO(0, 38, 66, 1),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _index += 1;
                            });
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 17),
                          )),
                    if (_index > 0 && _index <= 3)
                      FlatButton(
                          textColor: Color.fromRGBO(132, 0, 50, 1),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _index -= 1;
                            });
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 17),
                          )),
                  ],
                );
              },
              currentStep: _index,
              steps: <Step>[
                Step(
                  title: const Text('Basic Info'),
                  content: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value.trim().length <= 0) {
                              return "Enter a title";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            title = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Event Title',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLength: 100,
                          controller: descriptionController,
                          onChanged: (value) {
                            description = value;
                          },
                          validator: (value) {
                            if (value.trim().length <= 0) {
                              return "Enter a description";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Event Description',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Details'),
                  content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          DateTimePicker(submit: _submitDateTime),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: detailsController,
                            validator: (value) {
                              if (value.trim().length <= 0) {
                                return "Enter event details";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              details = value;
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Details/Rules',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                            ),
                          ),
                        ],
                      )),
                ),
                Step(
                    title: Text('Event Poster'),
                    content: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                            child: ImagePickWidget(_submitImage)),
                      ),
                    )),
                Step(
                    title: Text('Event Type'),
                    content: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Event Type"),
                          ListTile(
                            title: Text("General"),
                            leading: Radio<EventType>(
                              value: EventType.General,
                              groupValue: _type,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _type = value;
                                  open_to_all = true;
                                });
                                print(open_to_all);
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Member Specific"),
                            leading: Radio<EventType>(
                              value: EventType.MemberSpecific,
                              groupValue: _type,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _type = value;
                                  open_to_all = false;
                                });
                                print(open_to_all);
                              },
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          );
  }
}
