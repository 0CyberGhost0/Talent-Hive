import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_hive/services/authServices.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    void logInUser() {
      AuthService authService = AuthService();
      authService.logInUser(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }

    return Scaffold(
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                border: OutlineInputBorder(),
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 400,
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 400,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(emailController.text);
                print(passwordController.text);
                logInUser();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
