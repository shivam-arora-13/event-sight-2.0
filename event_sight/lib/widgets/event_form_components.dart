import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  var _selectedDate;
  var _selectedTime;
  var _selectedTimeString;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        FlatButton.icon(
          onPressed: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)))
                .then((pickedDate) {
              if (pickedDate == null) {
                return;
              }
              setState(() {
                _selectedDate = pickedDate;
              });
            });
          },
          icon: Icon(Icons.calendar_today),
          label: Text(_selectedDate != null
              ? _selectedDate.toString().substring(0, 10)
              : "Pick Date"),
        ),
        FlatButton.icon(
          onPressed: () {
            showTimePicker(context: context, initialTime: TimeOfDay.now())
                .then((pickedTime) {
              if (pickedTime == null) {
                return;
              }
              var localizations = MaterialLocalizations.of(context);
              var formattedTimeOfDay =
                  localizations.formatTimeOfDay(pickedTime);
              setState(() {
                _selectedTime = pickedTime;
                _selectedTimeString = formattedTimeOfDay;
              });
            });
          },
          icon: Icon(Icons.watch),
          label: Text(
              _selectedTimeString != null ? _selectedTimeString : "Pick Time"),
        )
      ],
    ));
  }
}

class ImagePickWidget extends StatefulWidget {
  @override
  _ImagePickWidgetState createState() => _ImagePickWidgetState();
}

class _ImagePickWidgetState extends State<ImagePickWidget> {
  File _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        if (_storedImage != null)
          Container(
            height: 400,
            width: 200,
            child: Image.file(
              _storedImage,
              fit: BoxFit.contain,
            ),
          ),
        FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera_alt),
            label: Text(_storedImage != null
                ? _storedImage.toString().substring(0, 30) + "...."
                : "Choose Poster"))
      ],
    ));
  }
}
