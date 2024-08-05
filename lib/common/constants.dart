import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String uri = "http://localhost:3000";
void showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
    ),
  );
}
