import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/common/colors.dart'; // Ensure this path is correct
import 'package:talent_hive/models/jobModel.dart';

class JobCard extends StatelessWidget {
  final Job job; // Add a Job parameter

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 220, // Set the fixed height for the JobCard
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(job.imageUrl), // Use job's imageUrl
                radius: 25,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title, // Use job's title
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 1, // Restrict title to one line
                    ),
                    SizedBox(height: 5),
                    Text(
                      job.org, // Use job's organization name
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 1, // Restrict organization to one line
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Skills Section with Horizontal Scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var skill in job.skill)
                  _buildSkillChip(skill), // Use job's skills
              ],
            ),
          ),
          Spacer(),
          // Salary and Arrow Icon in Separate Rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "\$${job.minSalary} - \$${job.maxSalary}", // Use job's salary range
                      style: GoogleFonts.poppins(
                        fontSize: 20, // Main salary text size
                        fontWeight: FontWeight.bold,
                        color:
                            homeGreenColor, // Use the homeGreenColor defined in colors.dart
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Skill Chip Widget
  Widget _buildSkillChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.green[800],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
