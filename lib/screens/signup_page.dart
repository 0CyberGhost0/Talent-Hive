import 'package:flutter/material.dart';
import 'package:talent_hive/services/authServices.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signUpUser() {
    AuthService authService = AuthService();
    authService.signUpUser(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );
  }

  Widget build(BuildContext context) {
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
                signUpUser();
              },
              child: Text("SignUp"),
            )
          ],
        ),
      ),
    );
  }
}
