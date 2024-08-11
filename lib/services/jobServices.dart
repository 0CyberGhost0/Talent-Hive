import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/models/jobModel.dart';
import 'package:http/http.dart' as http;
import 'package:talent_hive/screens/homeScreen.dart';

import '../common/constants.dart';

class JobServices {
  void postJob({
    required String title,
    required String organization,
    required String jobType,
    required String description,
    required List<String> skills,
    required int minSalary,
    required int maxSalary,
    required BuildContext context,
  }) async {
    try {
      var job = Job(
        title: title,
        org: organization,
        description: description,
        imageUrl: 'www.example.com',
        minSalary: minSalary,
        maxSalary: maxSalary,
        type: jobType,
        skill: skills,
      );
      http.Response res = await http.post(
        Uri.parse("$uri/job/postJob"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(job.toJson()),
      );
      print(res.body);
      if (res.statusCode == 200) {
        showSnackBar(context: context, text: "Job Posted Successfully!");
      }
    } catch (err) {
      print(err);
    }
  }

  void getCategoryJob(String category) async {
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/job/category/$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
    } catch (err) {
      print(err);
    }
  }

  void setSkill(
      List<String> skills, String userId, BuildContext context) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/job/setSkill"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": userId,
          "skill": skills,
        }),
      );
      httpErrorHandler(
          res: res,
          context: context,
          onSuccess: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
      print("SET SKILL: ${res.statusCode}");
    } catch (err) {
      print(err);
    }
  }

  Future<List<Job>> getFeaturedJob(String userId) async {
    List<Job> featuredJob = [];
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/job/featuredJob"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": userId,
        }),
      );

      if (res.statusCode == 200) {
        List<dynamic> jobsJson = jsonDecode(res.body);
        featuredJob = jobsJson.map((json) => Job.fromJson(json)).toList();
      }

      print("FEATURED JOB ${res.body}");
    } catch (err) {
      print("FEATURED JOB ERROR: $err");
    }
    return featuredJob;
  }
}
