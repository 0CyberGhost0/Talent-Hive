import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/common/colors.dart';
import 'package:talent_hive/widgets/skillChip.dart'; // Ensure this path is correct

class RecentJobCard extends StatelessWidget {
  final String title;
  final String organization;
  final String salaryRange;
  final int applicantCount;
  final List<String> skills;

  RecentJobCard({
    required this.title,
    required this.organization,
    required this.salaryRange,
    required this.applicantCount,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    //   return Card(
    //     margin: EdgeInsets.all(8.0),
    //     elevation: 5, // Adjust elevation for better visual
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               CircleAvatar(
    //                 backgroundColor:
    //                     homeGreenColor, // Use the color from colors.dart
    //                 child: Text(
    //                   title[0],
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               ),
    //               SizedBox(width: 10),
    //               Expanded(
    //                 child: Text(
    //                   title,
    //                   style: GoogleFonts.poppins(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                     color: homeGreenColor, // Matching color
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 8.0),
    //           Text(
    //             organization,
    //             style: GoogleFonts.poppins(
    //               color: Colors.grey[600], // Use a matching grey color
    //             ),
    //           ),
    //           SizedBox(height: 16.0),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Salary",
    //                     style: GoogleFonts.poppins(
    //                       color: Colors.grey[600], // Use a matching grey color
    //                     ),
    //                   ),
    //                   Text(
    //                     salaryRange,
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 24,
    //                       fontWeight: FontWeight.bold,
    //                       color: homeGreenColor, // Matching color
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Text(
    //                     "Applicants",
    //                     style: GoogleFonts.poppins(
    //                       color: Colors.grey[600], // Use a matching grey color
    //                     ),
    //                   ),
    //                   Text(
    //                     applicantCount.toString(),
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 24,
    //                       fontWeight: FontWeight.bold,
    //                       color: homeGreenColor, // Matching color
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 16.0),
    //           Wrap(
    //             spacing: 8.0,
    //             children: skills
    //                 .map((skill) => SkillChip(
    //                       skill: skill,
    //                     ))
    //                 .toList(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}
