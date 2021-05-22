import "package:flutter/material.dart";

import "./comment_section.dart";

class EventInfo extends StatefulWidget {
  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  var _isExpanded = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            child: Image.network(
              "https://piktochart.com/wp-content/uploads/2018/05/Brushstroke-Event-Flyer-7345706.png",
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
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _isExpanded[1] ? 200 : 0,
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
            duration: Duration(milliseconds: 500),
            height: _isExpanded[2] ? 200 : 0,
          ),
          Divider(thickness: 1),
          CommentSection()
        ],
      ),
    );
  }
}
