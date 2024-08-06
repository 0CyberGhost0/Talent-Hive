import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/screens/login_screen.dart';
import 'package:talent_hive/screens/signup_page.dart';
import 'package:talent_hive/services/authServices.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
  @override
  void initState() {
    authService.getUserData(context: context);
    super.initState();
  }
  // This widget is the root of your application.

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talent Hive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Provider.of<UserProvider>(context).user.token.isEmpty
      //     ? SignUpPage()
      //     :
      home: LoginScreen(),
    );
  }
}
