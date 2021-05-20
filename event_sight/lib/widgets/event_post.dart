import "package:flutter/material.dart";

class EventPost extends StatefulWidget {
  final imgUrl;
  EventPost(this.imgUrl);
  @override
  _EventPostState createState() => _EventPostState();
}

class _EventPostState extends State<EventPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text(""),
            trailing: Icon(Icons.verified_user),
          ),
          Container(
            width: double.infinity,
            height: 500,
            child: Image.network(
              widget.imgUrl,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.event),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
