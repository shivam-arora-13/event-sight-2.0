import "package:flutter/material.dart";

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 218, 218, 0.5),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            UserProfilePicture(),
            SizedBox(height: 10),
            Divider(),
            InfoTile("Leonardo Di Caprio", Icons.person),
            Divider(),
            InfoTile("19103007", Icons.info),
            Divider(),
            InfoTile("shivamarora.bt19cse@pec.edu.in", Icons.email),
            Divider(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 130,
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _index = 0;
                        });
                      },
                      child: Text(
                        "Member At",
                        style: TextStyle(
                            decoration:
                                _index == 0 ? TextDecoration.underline : null,
                            fontSize: 18,
                            color: _index == 0
                                ? Color.fromRGBO(0, 38, 66, 1)
                                : Colors.grey),
                      )),
                ),
                Container(
                  width: 0.5,
                  height: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 130,
                  child: FlatButton(
                      onPressed: () {
                        setState(() {
                          _index = 1;
                        });
                      },
                      child: Text(
                        "Follows",
                        style: TextStyle(
                            decoration:
                                _index == 1 ? TextDecoration.underline : null,
                            fontSize: 18,
                            color: _index == 1
                                ? Color.fromRGBO(0, 38, 66, 1)
                                : Colors.grey),
                      )),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            if (_index == 0) Text("List Of Membership clubs"),
            if (_index == 1) Text("List Of Following clubs")
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final _text;
  final _icon;
  InfoTile(this._text, this._icon);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _icon,
        size: 27,
        color: Color.fromRGBO(0, 38, 66, 1),
      ),
      title: Container(
        width: double.infinity,
        height: 25,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Text(
            _text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class UserProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 105,
      padding: EdgeInsets.all(3),
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
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(
              "https://resizing.flixster.com/eSrEPooElA53YIe489a-xQqHp-E=/506x652/v2/https://flxt.tmsimg.com/v9/AllPhotos/435/435_v9_bc.jpg"),
        ),
      ),
    );
  }
}
