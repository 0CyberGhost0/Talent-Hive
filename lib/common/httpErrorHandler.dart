import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  void showAwesomeSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  switch (res.statusCode) {
    case 200:
      onSuccess();
      showAwesomeSnackBar(
        context: context,
        title: 'Success!',
        message: jsonDecode(res.body)['msg'],
        contentType: ContentType.success,
      );
      break;
    case 400:
      showAwesomeSnackBar(
        context: context,
        title: 'Error!',
        message: jsonDecode(res.body)['error'],
        contentType: ContentType.failure,
      );
      break;
    case 500:
      showAwesomeSnackBar(
        context: context,
        title: 'Server Error!',
        message: jsonDecode(res.body)['error'],
        contentType: ContentType.failure,
      );
      break;
    default:
      showAwesomeSnackBar(
        context: context,
        title: 'Unknown Error!',
        message: 'An unexpected error occurred.',
        contentType: ContentType.failure,
      );
      break;
  }
}
