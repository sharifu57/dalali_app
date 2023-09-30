import 'package:dalali_app/service/logo.dart';
import 'package:flutter/material.dart';

class OwnerAunthentication extends StatefulWidget {
  const OwnerAunthentication({super.key});

  @override
  State<OwnerAunthentication> createState() => _OwnerAunthenticationState();
}

class _OwnerAunthenticationState extends State<OwnerAunthentication> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: fullHeight,
        width: fullWidth,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(child: Logo()),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text("Login with Credentials"),
            )
          ],
        ),
      )),
    );
  }
}
