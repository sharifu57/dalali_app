import 'dart:async';

import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/authentication/login.dart';
import 'package:dalali_app/screens/navigation/screen.dart';
import 'package:dalali_app/service/storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLocalStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: fullWidth,
        height: fullHeight,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            Expanded(
                child: Container(
                    child: Center(
              child: Text(
                "Logo Here",
                style: TextStyle(color: Colors.white),
              ),
            ))),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkLocalStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final phoneNumber = pref.getString("phone");

    if (phoneNumber != null ) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Screen(), // Replace with your main screen widget
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(), // Replace with your main screen widget
        ),
      );
    }
  }
}
