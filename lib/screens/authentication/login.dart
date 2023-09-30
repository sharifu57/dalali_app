import 'dart:async';
import 'dart:convert';

import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/authentication/verify.dart';
import 'package:dalali_app/service/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../service/config.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _phoneFormData = {};
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
        padding: EdgeInsets.all(20),
        color: AppColors.primaryColor,
        height: fullHeight,
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
                  child: Text("Logo"),
                ),
              ),
            ),
            Container(
              child: const Column(
                children: [
                  Text(
                    "Enter your ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    "mobile number",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 1),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 23),
              child: const Text(
                "You will receive a 6 digits code to verify next",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100),
              child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColors.secondaryColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 14,
                        )),
                    initialValue: "255",
                    keyboardType: TextInputType.phone,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLength: 12,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    validator: (value) {
                      if (value!.isEmpty || value.length != 12) {
                        return "invalid phone number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phoneFormData['phone_number'] = value;
                    },
                  )),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  sendPhoneNumber();
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                const Center(
                                  child: Text(
                                    "Send OTP",
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
      ))),
    );
  }

  Future sendPhoneNumber() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var submittedData = {"phone_number": _phoneFormData['phone_number']};

    final endpoint = '${config['apiBaseUrl']}/tennant/request_otp/';
    final data = json.encode(submittedData);

    var response = await sendPostRequest(context, endpoint, data);

    Timer(const Duration(seconds: 3), () {
      if (response != null) {
        if (response['status'] == 200) {
          String data = jsonEncode(response);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Verify(
                      phoneNumber: _phoneFormData['phone_number'],
                      otp: response['otp'])));
        } else {
       
        }
      } else {
        return null;
      }

      setState(() {
        _isLoading = false;
      });
    });
  }
}
