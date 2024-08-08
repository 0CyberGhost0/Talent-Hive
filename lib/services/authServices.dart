import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_hive/common/constants.dart';
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/models/user.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/screens/homeScreen.dart';
import 'package:talent_hive/screens/login_screen.dart';

class AuthService {
  void signUpUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      print("Inside SignUp");
      var user =
          User(name: "", id: '', email: email, password: password, token: '');
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
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
            print("Token: $token");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));

            showSnackBar(context: context, text: "Login Successfull");
          });
    } catch (err) {
      print(err);
    }
  }

  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        sharedPreferences.setString('x-auth-token', "");
      }
      print("before tokenValid");
      http.Response res = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "x-auth-token": token!
          });
      print(res.body);
      print("after tokenValid");

      var response = jsonDecode(res.body);

      if (response == true) {
        http.Response userData = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "x-auth-token": token
            });
        print("UserData: ${userData.body.toString()}");
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        print("before setuser");
        if (userData != null && userData.body != null) {
          print("setUser Called");
          userProvider.setUser(userData.body);
          print("after setUser called");
        }
        print("Email: ${userProvider.user.email}");
      }
    } catch (err) {
      print("Error Lol: $err");
    }
  }
}
