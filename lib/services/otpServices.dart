import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/screens/homeScreen.dart';
import 'package:talent_hive/screens/login_screen.dart';
import 'package:talent_hive/screens/skillSelectionScreen.dart';

import '../common/constants.dart';

class OTPService {
  void getOTP(String email) async {
    try {
      print("Inside getOTP()");
      http.Response res = await http.post(
        Uri.parse("$uri/getOtp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"email": email}),
      );
      print("after getOTP()");
    } catch (err) {
      print("GET OTP: $err");
    }
  }

  void verifyOTP(String otp, String email, BuildContext context) async {
    try {
      print("INSIDE Verify OTP");
      http.Response res = await http.post(
        Uri.parse("$uri/verifyOtp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "otp": otp,
          "email": email,
        }),
      );
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context: context, text: "User Verified Successfully");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          });
      print("VERIFY BODY: ${res.body}");
      print("AFTER Verify OTP");
    } catch (err) {
      print(err);
    }
  }
}
