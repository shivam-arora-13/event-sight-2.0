import "dart:io";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class DateTimePicker extends StatefulWidget {
  final submit;
  var intial_date = null;
  var initial_time = null;
  DateTimePicker({
    @required this.submit,
    this.intial_date,
    this.initial_time,
  });
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  var _selectedDate;
  var _selectedTime;
  var _selectedTimeString;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    if (widget.intial_date != null && flag) {
      _selectedDate = DateTime.parse(widget.intial_date);
      _selectedTime = TimeOfDay(
          hour: int.parse(widget.initial_time.substring(10, 12)),
          minute: int.parse(widget.initial_time.substring(13, 15)));
      _selectedTimeString = widget.initial_time;
      flag = false;
    }
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
              if (_selectedDate != null && _selectedTime != null) {
                widget.submit(_selectedDate, _selectedTimeString);
              }
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
              if (_selectedDate != null && _selectedTime != null) {
                widget.submit(_selectedDate, _selectedTime);
              }
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
  final _submitImage;
  ImagePickWidget(this._submitImage);
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
    widget._submitImage(_storedImage);
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
