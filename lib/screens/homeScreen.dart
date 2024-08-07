import 'package:flutter/material.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/services/authServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    print("email : ${user.email}");
    print(user.email.length);

    return Scaffold(
      body: Center(
        child: Text(
          user.email,
          style: TextStyle(
            fontSize: 100,
          ),
        ),
      ),
    );
  }
}
