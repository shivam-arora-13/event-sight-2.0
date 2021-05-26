import "dart:io";

import "package:flutter/material.dart";
import "./event_form_components.dart";

enum EventType { General, MemberSpecific }

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  int _index = 0;
  EventType _type = EventType.General;
  final _formKey = GlobalKey<FormState>();
  var title = "";
  var description = "";
  var details = "";
  var date;
  var time;
  File eventPoster;
  bool open_to_all;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    onPressed: () {},
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 17),
                    )),
              if (_index >= 0 && _index < 3)
                FlatButton(
                    textColor: Color.fromRGBO(0, 38, 66, 1),
                    onPressed: () {
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
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLength: 50,
                    decoration: InputDecoration(
                      suffixText: "50",
                      labelText: 'Event Description',
                      helperText: 'Max length 50',
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
                    DateTimePicker(),
                    SizedBox(height: 15),
                    TextFormField(
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
                  child: SingleChildScrollView(child: ImagePickWidget()),
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
                          });
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
                          });
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
