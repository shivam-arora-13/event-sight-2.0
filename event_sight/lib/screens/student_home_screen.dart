import "package:flutter/material.dart";
import "../widgets/top_bar.dart";
import "../widgets/event_post.dart";

class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(229, 218, 218, 0.5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            SizedBox(height: 5),
            EventPost(
                "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/music-event-poster-template-design-0f7370db1a770f45d14e2410bcb5c211_screen.jpg?ts=1580188883"),
            EventPost(
                "https://image.freepik.com/free-vector/music-event-poster-template-with-abstract-shapes_1361-1316.jpg"),
            EventPost(
                "https://i.pinimg.com/736x/3f/2e/a7/3f2ea75a5e55edc8af94a38d316890d0.jpg")
          ],
        ),
      ),
    );
  }
}
