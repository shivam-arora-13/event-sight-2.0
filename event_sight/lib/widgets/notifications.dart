import "package:flutter/material.dart";

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.all(10),
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 20,
              ),
              alignment: Alignment.centerRight,
            ),
            key: ValueKey(i),
            child: ListTile(
              title: Text(i.toString()),
            ));
      },
      itemCount: 10,
    );
  }
}
