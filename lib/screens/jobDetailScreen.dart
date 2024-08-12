import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/services/jobServices.dart';

import '../models/jobModel.dart';

class JobDetailScreen extends StatefulWidget {
  String jobId;
  JobDetailScreen({super.key, required this.jobId});
  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  void initState() {
    getJobData();
    super.initState();
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
      applyCount: 0);

  Future<void> getJobData() async {
    JobServices jobService = JobServices();
    print("JOB ID : ${widget.jobId}");
    Job fetchedJob = await jobService.getJobDetail(widget.jobId);
    setState(() {
      job = fetchedJob;
    });
    print("INSIDE SCREEN: ${job}");
  }

  @override
  Widget build(BuildContext context) {
    // Sample job data
    // final job = Job(
    //   title: 'Junior Front End Developer',
    //   org: 'Apple Computer, Inc.',
    //   description:
    //       'We’re looking for a junior front-end developer who works on building ith the application’s r who works on building the user . They showcase their skills with the application’s visual elements, including graphics, typography, and layouts. They also ensure smooth interaction between the app and users.We’re looking for a junior front-end developer who works  visual elements, including graphics, typography, and layouts. They also ensure smooth interaction between the app and users.We’re looking for a junior front-end developer who works on building the user interface of a mobile application or website. They showcase their skills with the ',
    //   imageUrl:
    //       'https://img.freepik.com/premium-vector/logo-google_798572-207.jpg',
    //   minSalary: 50,
    //   maxSalary: 100,
    //   type: 'Full Time',
    //   skill: [
    //     "Remote",
    //     "Fulltime",
    //     "Senior",
    //     "Front End",
    //   ],
    //   applyCount: 1478,
    // );

    return Scaffold(
      backgroundColor: Color(0xff305a53), // Background color matching the image
      body: SafeArea(
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
                        icon: Icon(Icons.arrow_back, color: Colors.white),
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
                    backgroundColor: Colors
                        .grey[200], // Optional: Background color for fallback
                    backgroundImage: NetworkImage(job.imageUrl),
                    onBackgroundImageError: (_, __) {
                      // Fallback when image fails to load
                    },
                    child: job.imageUrl == null
                        ? Icon(Icons.error,
                            color: Colors.red) // Fallback icon when no image
                        : null,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // Body Section
            Expanded(
              child: Container(
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
                          'Mountain View, CA',
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
                            margin: EdgeInsets.only(
                                right:
                                    2), // Margin to separate from the next container
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
                            margin: EdgeInsets.only(
                                left:
                                    10), // Margin to separate from the previous container
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
                    Spacer(),
                    // Footer Section
                    Row(
                      children: [
                        // Add Image Before Applicant Text
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
                          onPressed: () {
                            // Add apply job functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF00695C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                          ),
                          child: Text(
                            "Apply Job",
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
            ),
          ],
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
    return Chip(
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
    );
  }
}
