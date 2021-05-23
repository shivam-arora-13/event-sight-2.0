import "package:flutter/material.dart";

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(20, (index) => Comment()),
            ),
          ),
        ),
        AddComment(),
      ]),
    );
  }
}

class AddComment extends StatefulWidget {
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: NetworkImage(
            "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202105/gq-gal-gadot-accent.jpg?NrL3I.r683ECbshrlZvU0sIgZLE7AEnk&size=770:433"),
      ),
      title: TextField(),
      trailing: IconButton(
        icon: Icon(Icons.send),
        color: Color.fromRGBO(132, 0, 50, 1),
        onPressed: () {},
      ),
    );
  }
}

class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.06,
            backgroundImage: NetworkImage(
                "https://c.files.bbci.co.uk/111BB/production/_114057007_nolanreuters.jpg"),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.72,
            child: Text(
              "Christopher Nolan",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          subtitle: Container(
              width: MediaQuery.of(context).size.width * 0.72,
              child: Text("This is a Comment")),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.16,
            child: FittedBox(
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
                  IconButton(icon: Icon(Icons.comment), onPressed: () {})
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}

//add code for comment reply
