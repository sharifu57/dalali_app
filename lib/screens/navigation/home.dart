import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        height: fullHeight,
        width: fullWidth,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                      child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Hello",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
