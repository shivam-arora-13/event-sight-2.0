import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

import "./event_form_components.dart";

class EventEditForm extends StatefulWidget {
  final event;
  final Function submitUpdate;
  EventEditForm(this.event, this.submitUpdate);
  @override
  _EventEditFormState createState() => _EventEditFormState();
}

class _EventEditFormState extends State<EventEditForm> {
  final _formKey = GlobalKey<FormState>();
  bool open_to_all = false;
  bool flag = true;
  var date, time;
  bool dateTimeChanged = false;
  var newPoster = null;

  void _submitDateTime(pickedDate, pickedTime) {
    date = pickedDate;
    time = pickedTime;
    dateTimeChanged = true;
    // print(date);
    // print(time);
    // print(dateTimeChanged);
  }

  void submitNewPoster(poster) {
    newPoster = poster;
    // print("hello");
    // print(newPoster);
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      open_to_all = widget.event["open_to_all"];
    }
    final titleController = TextEditingController(text: widget.event["title"]);
    final detailController =
        TextEditingController(text: widget.event["details"]);
    final descriptionController =
        TextEditingController(text: widget.event["description"]);

    void trySubmit() {
      bool isValid = _formKey.currentState.validate();
      if (isValid) {
        widget.submitUpdate({
          "title": titleController.text,
          "description": descriptionController.text,
          "details": detailController.text,
          "open_to_all": open_to_all,
          "date_time_changed": dateTimeChanged,
          "date": date,
          "time": time,
          "new_poster": newPoster
        });
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
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
                  decoration: InputDecoration(
                      labelText: 'Event Title', suffixIcon: Icon(Icons.edit))),
              PosterChanger(widget.event["poster_url"], submitNewPoster),
              TextFormField(
                  controller: descriptionController,
                  maxLength: 100,
                  validator: (value) {
                    if (value.trim().length <= 0) {
                      return "Enter a description";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Event Description',
                      suffixIcon: Icon(Icons.edit))),
              DateTimePicker(
                submit: _submitDateTime,
                intial_date: widget.event["date"],
                initial_time: widget.event["time"],
              ),
              Divider(),
              TextFormField(
                  controller: detailController,
                  maxLines: 3,
                  validator: (value) {
                    if (value.trim().length <= 0) {
                      return "Enter event details";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Event Details',
                      suffixIcon: Icon(Icons.edit))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Open To All"),
                  Switch(
                      activeColor: Color.fromRGBO(229, 149, 0, 1),
                      value: open_to_all,
                      onChanged: (val) {
                        setState(() {
                          open_to_all = val;
                        });
                      })
                ],
              ),
              Divider(),
              RaisedButton.icon(
                  color: Color.fromRGBO(229, 149, 0, 1),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: trySubmit,
                  icon: Icon(Icons.save),
                  label: Text("Save Changes"))
            ],
          ),
        ),
      ),
    );
  }
}

class PosterChanger extends StatefulWidget {
  final initialUrl;
  final Function submitNewPoster;
  PosterChanger(this.initialUrl, this.submitNewPoster);
  @override
  _PosterChangerState createState() => _PosterChangerState();
}

class _PosterChangerState extends State<PosterChanger> {
  File newPoster = null;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    setState(() {
      newPoster = File(imageFile.path);
    });
    widget.submitNewPoster(newPoster);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 400,
      child: Stack(
        children: [
          newPoster == null
              ? Image.network(widget.initialUrl)
              : Image.file(newPoster),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(229, 149, 0, 1)),
                child: IconButton(
                    onPressed: _takePicture,
                    icon: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ))),
          )
        ],
      ),
    );
  }
}
