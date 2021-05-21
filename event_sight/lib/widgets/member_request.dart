import "package:flutter/material.dart";
import "../screens/student_profile.dart";

class MemberRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              UserProfilePicture(),
            ],
          ),
          Container(
            color: Colors.white70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MemberRequestButtons(),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      color: Colors.white54,
      //add conditions for only one request
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.1,
          bottom: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
    );
  }
}

class MemberRequestButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_add,
              size: 40,
            ),
            color: Color.fromRGBO(0, 38, 66, 1),
          ),
          VerticalDivider(
            width: 10,
            indent: 70,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cancel_outlined,
              size: 40,
            ),
            color: Color.fromRGBO(132, 0, 50, 1),
          ),
        ]);
  }
}

class InfoTile extends StatelessWidget {
  final icon;
  final String info;
  InfoTile(this.icon, this.info);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(info),
    );
  }
}
