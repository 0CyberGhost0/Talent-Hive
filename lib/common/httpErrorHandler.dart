import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:talent_hive/common/constants.dart';

void httpErrorHandler({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      // showSnackBar(context: context, text: jsonDecode(res.body)['msg']);
      onSuccess();
      break;
    case 400:
      showSnackBar(context: context, text: jsonDecode(res.body)['error']);
      break;
    case 500:
      showSnackBar(context: context, text: jsonDecode(res.body)['error']);
      break;
    default:
      showSnackBar(context: context, text: jsonDecode(res.body));
      break;
  }
}
