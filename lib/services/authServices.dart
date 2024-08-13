import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/models/user.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/screens/otpScreen.dart';
import 'package:talent_hive/screens/skillSelectionScreen.dart';
import 'package:talent_hive/services/otpServices.dart';

import '../common/constants.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var user = User(
        name: '',
        id: '',
        email: email,
        password: password,
        token: '',
        skills: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          OTPService otpService = OTPService();
          otpService.getOTP(email, context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OTPScreen(email: jsonDecode(res.body)['email']),
            ),
          );
        },
      );
    } catch (e) {
      print("Error in signUpUser: $e");
    }
  }

  void logInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'x-auth-token', jsonDecode(res.body)['token']);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SkillsSelectionPage()));
        },
      );
    } catch (err) {
      print("Error in logInUser: $err");
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("x-auth-token") ?? "";

      http.Response res = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": token,
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () async {
          http.Response userData = await http.get(
            Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "x-auth-token": token,
            },
          );

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          if (userData.body.isNotEmpty) {
            userProvider.setUser(userData.body);
          }
        },
      );
    } catch (err) {
      print("Error in getUserData: $err");
    }
  }
}
