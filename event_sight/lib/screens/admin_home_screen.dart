import "package:flutter/material.dart";

import "../widgets/home_screen_elements.dart";
import "./event_screen.dart";

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 5),
                      ClubLogo(
                          "https://cdn.designrush.com/uploads/inspiration_images/4531/990__1511456189_555_McDonald's.png"),
                      SizedBox(width: 5),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClubStat(126, "Events"),
                            ClubStat(346, "Members"),
                            ClubStat(569, "Followers"),
                          ],
                        ),
                      )
                    ],
                  ),
                  ClubInfo(),
                  ClubButtons(),
                ],
              ),
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height * 0.47,
              child: GridView(
                  children: [
                    ...List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(EventScreen.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          width: 100,
                          height: 100,
                          child: Image.network(
                              "https://venngage-wordpress-gallery.s3.amazonaws.com/uploads/2018/10/25.jpg"),
                        ),
                      );
                    }),
                    ...List.generate(8, (index) {
                      return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          width: 100,
                          height: 100,
                          child: Image.network(
                              "https://image.freepik.com/free-vector/music-event-poster-template-with-colorful-shapes_1361-1591.jpg"));
                    })
                  ],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5)),
            )
          ],
        ),
      ),
    );
  }
}
