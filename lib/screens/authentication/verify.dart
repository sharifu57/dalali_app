import 'package:dalali_app/partials/colors.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  final phoneNumber;
  final otp;
  const Verify({super.key, required this.phoneNumber, required this.otp});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          height: fullHeight,
          width: fullWidth,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Card(
                        color: AppColors.secondaryColor,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Container(
                  child: Center(
                    child: Text(
                      "Verify Phone",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Code was sent to"),
                    Text(
                      " ${widget.phoneNumber}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                child: Form(child: ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
