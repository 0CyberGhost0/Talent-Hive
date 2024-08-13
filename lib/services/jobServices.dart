import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_hive/common/httpErrorHandler.dart';
import 'package:talent_hive/models/jobModel.dart';
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
    required int applyCount,
    required BuildContext context,
    required String location,
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
        applyCount: applyCount,
        location: location,
      );

      http.Response res = await http.post(
        Uri.parse("$uri/job/postJob"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(job.toJson()),
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          showSnackBar(context: context, text: "Job Posted Successfully!");
        },
      );
    } catch (err) {
      print("POST JOB ERROR: $err");
    }
  }

  Future<List<Job>> getCategoryJob(
      String category, BuildContext context) async {
    List<Job> categoryJob = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/job/category/$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          List<dynamic> jobsJson = jsonDecode(res.body);
          categoryJob = jobsJson.map((json) => Job.fromJson(json)).toList();
        },
      );
    } catch (err) {
      print("CATEGORY JOB ERROR: $err");
    }
    return categoryJob;
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
    } catch (err) {
      print("SET SKILL ERROR: $err");
    }
  }

  Future<List<Job>> getFeaturedJob(String userId, BuildContext context) async {
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

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          List<dynamic> jobsJson = jsonDecode(res.body);
          featuredJob = jobsJson.map((json) => Job.fromJson(json)).toList();
        },
      );
    } catch (err) {
      print("FEATURED JOB ERROR: $err");
    }
    return featuredJob;
  }

  Future<List<Job>> getRecentJob(BuildContext context) async {
    List<Job> recentJob = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/job/recentJob"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          List<dynamic> jobsJson = jsonDecode(res.body);
          recentJob = jobsJson.map((json) => Job.fromJson(json)).toList();
        },
      );
    } catch (err) {
      print("RECENT JOB ERROR: $err");
    }
    return recentJob;
  }

  Future<List<Job>> searchJob(String query, BuildContext context) async {
    List<Job> searchResult = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/job/searchJob/$query"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          List<dynamic> jobsJson = jsonDecode(res.body);
          searchResult = jobsJson.map((json) => Job.fromJson(json)).toList();
        },
      );
    } catch (err) {
      print("SEARCH JOB ERROR: $err");
    }
    return searchResult;
  }

  Future<Job> getJobDetail(String jobId, BuildContext context) async {
    Job job = Job(
      location: '',
      jobId: '',
      title: '',
      org: '',
      description: '',
      imageUrl: '',
      minSalary: 0,
      maxSalary: 0,
      type: '',
      skill: [],
      applyCount: 0,
    );

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/job/search/${jobId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          job = Job.fromJson(jsonDecode(res.body));
        },
      );
    } catch (err) {
      print("JOB DETAIL ERROR: $err");
    }
    return job;
  }

  Future<void> applyToJob(
      String userId, String jobId, BuildContext context) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/job/apply"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": userId,
          "jobId": jobId,
        }),
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          // showSnackBar(context: context, text: "Job Applied Successfully!");
        },
      );
    } catch (err) {
      print("APPLY JOB ERROR: $err");
    }
  }

  Future<bool> hasApplied(
      String userId, String jobId, BuildContext context) async {
    bool applied = false;
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/job/hasApplied"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": userId,
          "jobId": jobId,
        }),
      );

      httpErrorHandler(
        res: res,
        context: context,
        onSuccess: () {
          applied = jsonDecode(res.body);
        },
      );
    } catch (err) {
      print("HAS APPLIED ERROR: $err");
    }
    return applied;
  }
}
