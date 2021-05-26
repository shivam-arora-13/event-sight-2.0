import "package:flutter/material.dart";
import "../widgets/member_request.dart";

class MemberRequestScreen extends StatefulWidget {
  @override
  _MemberRequestScreenState createState() => _MemberRequestScreenState();
}

class _MemberRequestScreenState extends State<MemberRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 38, 66, 1),
              Color.fromRGBO(132, 0, 50, 1),
            ]),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // MemberRequest(),
          // MemberRequest(),
          // MemberRequest(),
        ],
      ),
    );
  }
}
