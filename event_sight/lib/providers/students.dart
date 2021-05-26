import "package:flutter/foundation.dart";

class Student {
  final String sid;
  final String name;
  final String email;
  final String session_role;
  final String imgUrl;
  List<String> following = [];
  List<String> memberAt = [];
  Student({
    @required this.sid,
    @required this.name,
    @required this.email,
    @required this.session_role,
    @required this.imgUrl,
  });
}
