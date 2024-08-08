import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/common/colors.dart';

class SkillChip extends StatelessWidget {
  late String skill;
  SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          skill,
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
