import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/common/colors.dart'; // Ensure this path is correct
import 'package:talent_hive/models/jobModel.dart';
import 'package:talent_hive/screens/jobDetailScreen.dart';

class RecentJobCard extends StatelessWidget {
  final Job job;

  const RecentJobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetailScreen(jobId: job.jobId!)));
      },
      child: Container(
        width: double
            .infinity, // Make the card cover the entire width of the screen
        margin: EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical spacing
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
                  backgroundImage: NetworkImage(job.imageUrl),
                  radius: 25,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 5),
                      Text(
                        job.org,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                  for (var skill in job.skill) _buildSkillChip(skill),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Salary and Applicant Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Salary / Month',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$${job.minSalary} - \$${job.maxSalary}",
                      style: GoogleFonts.poppins(
                        fontSize: 25, // Increased to match JobCard
                        fontWeight: FontWeight.bold,
                        color: homeGreenColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Applicants',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/apply.png',
                          height: 24.0,
                          width: 24.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '${job.applyCount.toString()}',
                          style: GoogleFonts.poppins(
                            fontSize: 25.0, // Increased to match JobCard
                            fontWeight: FontWeight.bold,
                            color: homeGreenColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            // Green Arrow Button at Bottom Right
          ],
        ),
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
