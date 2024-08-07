import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_hive/common/colors.dart';
import 'package:talent_hive/screens/signup_page.dart';
import 'package:talent_hive/services/authServices.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                "Hello Again!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                  fontSize: 37,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Welcome Back You've\nbeen missed!",
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
              CustomTextField("Enter Email", Icons.email_outlined),
              CustomTextField("Password", Icons.password_outlined),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor2,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
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
                                builder: (context) => SignUpPage()));
                      },
                      child: Text.rich(TextSpan(
                        text: "Not a member?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textColor2,
                        ),
                        children: const [
                          TextSpan(
                            text: " Register Now",
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

  Container CustomTextField(String hintText, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
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

  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TextField(
  //             controller: emailController,
  //             decoration: InputDecoration(
  //               labelText: 'Enter Email',
  //               border: OutlineInputBorder(),
  //               constraints: BoxConstraints(
  //                 maxHeight: 300,
  //                 maxWidth: 400,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           TextField(
  //             controller: passwordController,
  //             decoration: InputDecoration(
  //               labelText: 'Enter Password',
  //               border: OutlineInputBorder(),
  //               constraints: BoxConstraints(
  //                 maxHeight: 300,
  //                 maxWidth: 400,
  //               ),
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               print(emailController.text);
  //               print(passwordController.text);
  //               logInUser();
  //             },
  //             child: Text("Login"),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
