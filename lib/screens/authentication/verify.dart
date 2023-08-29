import 'dart:async';
import 'dart:convert';

import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/authentication/login.dart';
import 'package:dalali_app/screens/navigation/screen.dart';
import 'package:dalali_app/service/api.dart';
import 'package:dalali_app/service/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verify extends StatefulWidget {
  final String phoneNumber;
  final String otp;
  const Verify({super.key, required this.phoneNumber, required this.otp});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _verifyFormData = {};
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    OtpFieldController otpController = OtpFieldController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        focusColor: AppColors.secondaryColor,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.cleaning_services,
          color: Colors.white,
        ),
        onPressed: () {
          print("Floating button was pressed.");
          // otpController.clear();
          // otpController.set(['']);
        },
      ),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
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
                    Column(
                      children: [
                        Text(
                          " ${widget.phoneNumber}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${widget.otp}")
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: OTPTextField(
                          controller: otpController,
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                            _verifyFormData['otp'] = pin;
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                          }),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    verifyOTP();
                  },
                  child: SizedBox(
                    width: fullWidth / 3,
                    child: _isLoading
                        ? const SpinKitWave(
                            color: AppColors.secondaryColor,
                            size: 20.0,
                          )
                        : Card(
                            color: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  const Center(
                                    child: Text(
                                      "Verify OTP",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future verifyOTP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    print("______print otp");
    print(_verifyFormData['otp']);

    try {
      final submittedData = {
        "phone_number": widget.phoneNumber,
        "otp": _verifyFormData['otp'],
      };

      print("______submitted data");
      print(submittedData);

      final endpoint = '${config['apiBaseUrl']}/tennant/verify_otp/';
      final data = json.encode(submittedData);
      print("${config['apiBaseUrl']}/tennant/verify_otp/");
      print("____url");
      print(data);

      final response = await Dio().post(endpoint, data: data);
      print(response);
      // ignore: unnecessary_null_comparison
      if (response != null) {
        print("____response is not null");
        if (response.statusCode == 200) {
          print("______success");
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("phone", response.data['phone_number']);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const Screen(), // Replace with the screen you want to navigate to
            ),
          );
        } else {
          showErrorDialog(response.data['message']);
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print("______there is no rresponse");
        showErrorDialog(response.data['message']);
        setState(() {
          _isLoading = false;
        });
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print("Error during OTP verification: $error");
      setState(() {
        _isLoading = false;
      });
    } finally {
      showErrorDialog("Something is not Right");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
