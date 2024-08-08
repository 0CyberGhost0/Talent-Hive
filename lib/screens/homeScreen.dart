import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/common/colors.dart';

import '../widgets/jobCard.dart'; // Ensure this path is correct

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 28),
                  Row(
                    children: [
                      Icon(Icons.notifications_outlined, size: 28),
                      SizedBox(width: 20),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 20,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Welcome Text and Search Button
              Text(
                "Find Your Dream Job",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for jobs",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Categories Section
              Text(
                "Categories",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip("Remote"),
                    _buildCategoryChip("Full-time"),
                    _buildCategoryChip("Part-time"),
                    _buildCategoryChip("Contract"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Featured Jobs Section
              Text(
                "Featured Jobs",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                    JobCard(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Recent Jobs",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // Category Chip Widget
  Widget _buildCategoryChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Job Card Widget

  // Skill Chip Widget
}
