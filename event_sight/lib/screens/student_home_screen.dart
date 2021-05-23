import "package:flutter/material.dart";
import "../widgets/top_bar.dart";
import "../widgets/event_card.dart";

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(),
          SizedBox(height: 5),
          EventCard(
              "https://i.pinimg.com/originals/7a/29/57/7a2957800ee9f78fc657a447d467b0fc.png",
              "The Institution of Electronics and Telecommunication Engineers"),
          EventCard(
              "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/5197ce65322745.5af099013686d.png",
              "Art and Photography club")
        ],
      ),
    );
  }
}
