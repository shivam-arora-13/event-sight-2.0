import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ClubLogo extends StatelessWidget {
  final imgUrl;
  ClubLogo(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 38, 66, 1),
              Color.fromRGBO(132, 0, 50, 1),
              Color.fromRGBO(229, 149, 0, 1),
            ],
          )),
      child: Container(
        height: 74,
        width: 74,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ClubStat extends StatelessWidget {
  final int n;
  final String label;
  ClubStat(this.n, this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "$n",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ClubButtons extends StatefulWidget {
  final organiserId;
  var followersList;
  var membersList;
  ClubButtons(
    this.organiserId,
    this.followersList,
    this.membersList,
  );

  @override
  _ClubButtonsState createState() => _ClubButtonsState();
}

class _ClubButtonsState extends State<ClubButtons> {
  var isLoading = false;
  void addStudent(String type, BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (type == "followers") {
        widget.followersList.add(FirebaseAuth.instance.currentUser.uid);
        await FirebaseFirestore.instance
            .collection("organisers")
            .doc(widget.organiserId)
            .update({"followers": widget.followersList});
      } else {
        await FirebaseFirestore.instance.collection("member_requests").add({
          "organiser": widget.organiserId,
          "students": FirebaseAuth.instance.currentUser.uid
        });
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
            type == "followers" ? "Started following" : "Member request sent"),
        backgroundColor: Colors.green,
      ));
    } catch (err) {
      var message = "Error occured";
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          addStudent("followers", context);
                        },
                  child: Text("Follow"),
                  color: Color.fromRGBO(229, 149, 0, 1),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 170,
                child: RaisedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          addStudent("members", context);
                        },
                  textColor: Colors.white,
                  child: Text("Request Membership"),
                  color: Color.fromRGBO(0, 38, 66, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClubInfo extends StatelessWidget {
  final title;
  final description;
  ClubInfo(this.title, this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 38, 66, 1),
            ),
          ),
          SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
