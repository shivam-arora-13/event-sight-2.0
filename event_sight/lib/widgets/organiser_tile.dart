import "package:flutter/material.dart";

class OrganiserTile extends StatelessWidget {
  final name;
  final description;
  final image_url;
  final no_of_followers;
  final no_of_members;
  OrganiserTile(
    this.name,
    this.description,
    this.image_url,
    this.no_of_followers,
    this.no_of_members,
  );
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
                        Text(
                          name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        Text(description,
                            style: TextStyle(color: Colors.black87)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("$no_of_members Members"),
                        Text("$no_of_followers Followers"),
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
                    image_url,
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
