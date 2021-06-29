import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import "./comment_section.dart";

class EventInfo extends StatefulWidget {
  final eventId;
  final bool isAdmin;
  EventInfo(this.eventId, this.isAdmin);
  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("events")
            .doc(widget.eventId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          var eventInfo = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoColumn(
                  eventInfo["poster_url"],
                  eventInfo["title"],
                  eventInfo["description"],
                  eventInfo["date"],
                  eventInfo["time"],
                  eventInfo["details"],
                ),
                CommentSection(widget.isAdmin, widget.eventId),
              ],
            ),
          );
        });
  }
}

class InfoColumn extends StatefulWidget {
  final posterUrl;
  final title;
  final description;
  final date;
  final time;
  final details;
  InfoColumn(
    this.posterUrl,
    this.title,
    this.description,
    this.date,
    this.time,
    this.details,
  );
  @override
  _InfoColumnState createState() => _InfoColumnState();
}

class _InfoColumnState extends State<InfoColumn> {
  var _isExpanded = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _isExpanded[0] = !_isExpanded[0];
            });
          },
          title: Text("Poster"),
          trailing: _isExpanded[0]
              ? Icon(Icons.expand_less)
              : Icon(Icons.expand_more),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: _isExpanded[0] ? 500 : 0,
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width - 10,
          child: Image.network(
            widget.posterUrl,
            fit: BoxFit.contain,
          ),
        ),
        ListTile(
            onTap: () {
              setState(() {
                _isExpanded[1] = !_isExpanded[1];
              });
            },
            title: Text("Description"),
            trailing: _isExpanded[1]
                ? Icon(Icons.expand_less)
                : Icon(Icons.expand_more)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(widget.description),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 3),
                      Text(DateTime.parse(widget.date)
                          .toString()
                          .substring(0, 10)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.watch,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 3),
                      Text(widget.time.toString().substring(10, 15)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          height: _isExpanded[1] ? 150 : 0,
        ),
        ListTile(
            onTap: () {
              setState(() {
                _isExpanded[2] = !_isExpanded[2];
              });
            },
            title: Text("Details / Rules"),
            trailing: _isExpanded[2]
                ? Icon(Icons.expand_less)
                : Icon(Icons.expand_more)),
        AnimatedContainer(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10),
          duration: Duration(milliseconds: 500),
          height: _isExpanded[2] ? 150 : 0,
          child: SingleChildScrollView(
            child: Text(
              widget.details,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}
