import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0, yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 30 : 0),
        boxShadow: isDrawerOpen
            ? [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: Offset(3, 3),
                ),
              ]
            : null,
      ),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isDrawerOpen = !isDrawerOpen;
                    if (isDrawerOpen) {
                      // xOffset = 230;
                      // yOffset = 150;
                      // scaleFactor = 0.6;

                      xOffset = 190;
                      yOffset = 85;
                      scaleFactor = 0.8;
                    } else {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                    }
                  });
                },
                icon: Icon(isDrawerOpen ? Icons.arrow_back : Icons.menu),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
