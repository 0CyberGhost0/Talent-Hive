import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_hive/common/colors.dart';
import 'package:talent_hive/screens/login_screen.dart';
import 'package:talent_hive/services/authServices.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void registerUser() {
      AuthService authService = AuthService();
      print(nameController.text);
      print(emailController.text);
      print(passwordController.text);
      authService.signUpUser(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                  fontSize: 37,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Create an Account to get started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor2,
                  fontSize: 27,
                  height: 1.2,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField(
                  "Enter Name", nameController, Icons.person_outline),
              CustomTextField(
                  "Enter Email", emailController, Icons.email_outlined),
              CustomTextField(
                  "Password", passwordController, Icons.password_outlined,
                  isPassword: true),
              SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: registerUser,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text.rich(TextSpan(
                        text: "Already a member?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor2,
                        ),
                        children: const [
                          TextSpan(
                            text: " Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container CustomTextField(
      String hintText, TextEditingController textController, IconData icon,
      {bool isPassword = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        controller: textController,
        obscureText:
            isPassword, // This will hide the text if isPassword is true
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 19,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
