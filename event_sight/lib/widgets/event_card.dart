import "package:flutter/material.dart";
import "./comment_section.dart";

class EventCard extends StatefulWidget {
  final clubName;
  final imgUrl;
  EventCard(this.imgUrl, this.clubName);
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.055,
              backgroundImage: NetworkImage(
                  "https://cdn.designrush.com/uploads/inspiration_images/4531/990__1511456189_555_McDonald's.png"),
            ),
            trailing: true
                ? Icon(
                    Icons.verified_user,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 25,
                alignment: Alignment.centerLeft,
                child: FittedBox(
                    child: Text(
                  widget.clubName.length > 30
                      ? widget.clubName.substring(0, 30) + "..."
                      : widget.clubName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ))),
          ),
          Container(
            height: 500,
            child: Image.network(widget.imgUrl, fit: BoxFit.contain),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.event,
                        size: 27,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        _isExpanded ? Icons.comment : Icons.comment_outlined,
                        size: 27,
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
                      ),
                      onPressed: () {}),
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    size: 30,
                  ),
                  onPressed: () {})
            ],
          ),
          if (_isExpanded)
            AnimatedContainer(
                height: _isExpanded ? 60 : 0,
                duration: Duration(milliseconds: 500),
                child: AddComment()),
          Divider(
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
