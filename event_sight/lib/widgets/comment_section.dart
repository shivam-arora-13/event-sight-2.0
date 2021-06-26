import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentSection extends StatefulWidget {
  final bool isAdmin;
  final eventId;
  CommentSection(this.isAdmin, this.eventId);
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  bool showComments = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ListTile(
          onTap: () {
            setState(() {
              showComments = !showComments;
            });
          },
          title: Text("Comments"),
          trailing:
              showComments ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
        ),
        if (showComments)
          AnimatedContainer(
            height: showComments ? 500 : 0,
            duration: Duration(seconds: 3),
            child: Column(
              children: [
                Container(
                    height: 350,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("comment")
                          .where("eventId", isEqualTo: widget.eventId)
                          .snapshots(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [CircularProgressIndicator()],
                          );
                        }

                        var comments = [];
                        comments = snapshot.data.docs as List<dynamic>;
                        //print(comments);
                        return ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (ctx, i) {
                              return Comment(
                                comments[i]["name"],
                                comments[i]["img_url"],
                                comments[i]["comment_text"],
                              );
                            });
                      },
                    )),
                AddComment(widget.isAdmin, widget.eventId),
              ],
            ),
          ),
      ]),
    );
  }
}

class AddComment extends StatefulWidget {
  final isAdmin;
  final eventId;
  AddComment(this.isAdmin, this.eventId);
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  var commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void submitComment(imgUrl, name, commentText) async {
    //
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      await FirebaseFirestore.instance.collection("comment").add({
        "eventId": widget.eventId,
        "img_url": imgUrl,
        "name": name,
        "comment_text": commentText
      });
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.isAdmin
            ? FirebaseFirestore.instance
                .collection("organisers")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get()
            : FirebaseFirestore.instance
                .collection("students")
                .where("id", isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          var userData = widget.isAdmin
              ? snapshot.data
              : (snapshot.data.docs as List<dynamic>)[0];

          return ListTile(
            leading: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(userData["image_url"]),
            ),
            title: Form(
              key: _formKey,
              child: TextFormField(
                controller: commentController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter a comment";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Add a comment",
                ),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.send),
              color: Color.fromRGBO(132, 0, 50, 1),
              onPressed: () {
                //FocusScope.of(ctx).unfocus();
                submitComment(userData["image_url"], userData["name"],
                    commentController.text);
              },
            ),
          );
        });
  }
}

class Comment extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String commentText;
  Comment(this.name, this.imgUrl, this.commentText);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.06,
            backgroundImage: NetworkImage(imgUrl),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.72,
            child: Text(
              name,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          subtitle: Container(
              width: MediaQuery.of(context).size.width * 0.72,
              child: Text(commentText)),
        ),
        Divider()
      ],
    );
  }
}

//add code for comment reply
