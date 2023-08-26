import 'dart:async';

import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/authentication/login.dart';
import 'package:flutter/material.dart';

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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
      // checkFirstTimeUser().then((isFirstTime) {
      //   if (isFirstTime) {
      //     // First-time user, navigate to the Introduction page.
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => Login()),
      //     );
      //   } else {
      //     // Returning user, navigate to the Home page.
      //     Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => Login()),
      //     );
      //   }
      // });
    });
  }

  // Future<bool> checkFirstTimeUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  //   // If it's the first time, save the flag in shared preferences.
  //   if (isFirstTime) {
  //     await prefs.setBool('isFirstTime', false);
  //   }

  //   return isFirstTime;
  // }

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
}
