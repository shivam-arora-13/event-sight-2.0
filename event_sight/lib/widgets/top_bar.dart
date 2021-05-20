import "package:flutter/material.dart";

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      margin: EdgeInsets.all(5),
      height: 90,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        ...new List<int>.generate(2, (i) => i + 1)
            .map((e) => TopBarItem(
                "https://images.jdmagicbox.com/comp/chandigarh/c4/0172p1762.1762.110201201416.l1c4/catalogue/punjab-engineering-college-sector-12-chandigarh-placement-services-candidate--3er9sw3.jpg?clr=#006600"))
            .toList(),
        ...new List<int>.generate(5, (i) => i + 1)
            .map((e) => TopBarItem(
                "https://cdn.designrush.com/uploads/inspiration_images/4531/990__1511456189_555_McDonald's.png"))
            .toList()
      ]),
    );
  }
}

class TopBarItem extends StatelessWidget {
  final imgUrl;
  TopBarItem(this.imgUrl);
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
