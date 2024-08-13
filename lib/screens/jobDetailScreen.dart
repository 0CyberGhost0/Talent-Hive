import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/services/jobServices.dart';
import '../models/jobModel.dart';

class JobDetailScreen extends StatefulWidget {
  final String jobId;
  JobDetailScreen({Key? key, required this.jobId}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  bool isApplied = false; // State variable to track if the job is applied

  @override
  void initState() {
    super.initState();
    checkApplicationStatus(); // Check if the user has already applied
    getJobData();
  }

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

  Future<void> getJobData() async {
    JobServices jobService = JobServices();
    Job fetchedJob = await jobService.getJobDetail(widget.jobId, context);
    setState(() {
      job = fetchedJob;
    });
  }

  Future<void> checkApplicationStatus() async {
    JobServices jobServices = JobServices();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    bool applied = await jobServices.hasApplied(user.id, widget.jobId, context);
    setState(() {
      isApplied = applied;
    });
  }

  Future<void> applyToJob() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    JobServices jobServices = JobServices();
    await jobServices.applyToJob(user.id, widget.jobId, context);
    setState(() {
      isApplied = true;
      job.applyCount += 1; // Update the state to reflect the application
    });
  }

  @override
  Widget build(BuildContext context) {
    // Generate a random number between 1 and 8 for the logo image
    final int randomNum = Random().nextInt(17) + 1;

    return Scaffold(
      backgroundColor: Color(0xff305a53), // Background color matching the image
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            job.org,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          AssetImage('assets/images/logo$randomNum.jpg'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Body Section
              Container(
                padding: EdgeInsets.all(34),
                decoration: BoxDecoration(
                  color: Color(0xfff3f3f3),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      job.title,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Location with Icon
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 4),
                        Text(
                          '${job.org}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 15),
                        Icon(Icons.location_on,
                            color: Colors.black54, size: 16),
                        Text(
                          job.location,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Row containing separate containers for Salary/Hours and Job Type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: _buildInfoChipWithImage(
                                'assets/images/dollar.png',
                                '\$${job.minSalary} - \$${job.maxSalary}',
                                'Salary / Hours'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: _buildInfoChipWithImage(
                                'assets/images/jobType.png',
                                job.type,
                                'Job Type'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Job Details",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      job.description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: job.skill
                          .map((skill) => _buildSkillChip(skill))
                          .toList(),
                    ),
                    SizedBox(height: 20),
                    // Footer Section
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/apply.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Applicant",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              job.applyCount.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: isApplied ? null : applyToJob,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isApplied
                                ? Colors.blue
                                : Color(
                                    0xFF00695C), // Change color when applied
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: Text(
                            isApplied
                                ? "Applied"
                                : "Apply Job", // Change text when applied
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build Info Chip with Image
  Widget _buildInfoChipWithImage(String imagePath, String value, String label) {
    return Row(
      children: [
        // Image Column
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
            ),
          ],
        ),
        SizedBox(width: 16), // Spacing between image and text
        // Text Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4), // Spacing between value and label
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Skill Chip Widget
  Widget _buildSkillChip(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: Chip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        side: BorderSide.none, // No border for the skill chips
      ),
    );
  }
}
