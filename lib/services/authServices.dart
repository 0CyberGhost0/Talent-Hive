import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_hive/common/constants.dart';
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/models/user.dart';

class AuthService {
  void signUpUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      print("Inside SignUp");
      var user = User(id: '', email: email, password: password);
      http.Response res = await http.post(
        Uri.parse('$uri/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.statusCode);
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context: context, text: "Account Created Successfully!");
          });
    } catch (e) {
      print(e);
    }
  }

  void logInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      print(jsonEncode({"email": email, "password": password}));
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
            var token = sharedPreferences.getString('x-auth-token');
            print(token);

            showSnackBar(context: context, text: "Login Successfull");
          });
    } catch (err) {
      print(err);
    }
  }
}
