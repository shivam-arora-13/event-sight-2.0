import "package:flutter/material.dart";

class OrganiserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: [
          Container(
            color: Colors.white70,
            height: 100,
            margin: EdgeInsets.only(top: 10, right: 15, left: 50),
            padding: EdgeInsets.only(top: 2, bottom: 2, right: 3, left: 40),
            child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Art and Photography Club"),
                        Text("APC"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("393 Members"),
                        Text("897 Followers"),
                      ],
                    )
                  ],
                )),
          ),
          Positioned(
              top: 25,
              left: 17.5,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(33),
                  child: Image.network(
                    "https://cdn.designrush.com/uploads/inspiration_images/4531/990__1511456189_555_McDonald's.png",
                    fit: BoxFit.cover,
                  ),
                ),
                height: 70,
                width: 70,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
