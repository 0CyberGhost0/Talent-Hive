import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/provider/user_provider.dart';
import 'package:talent_hive/screens/postJobScreen.dart';
import 'package:talent_hive/services/authServices.dart';
import 'package:talent_hive/services/jobServices.dart';
import '../models/jobModel.dart';
import '../widgets/jobCard.dart'; // For Featured Jobs
import '../widgets/recentJobCard.dart'; // For Recent Jobs

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Job> featuredJobs = []; // Store the fetched featured jobs here
  List<Job> recentJobs = []; // Store the fetched recent jobs here

  @override
  void initState() {
    super.initState();
    AuthService authService = AuthService();
    authService.getUserData(context: context);
    getFeaturedData();
    // getRecentData();
  }

  void getFeaturedData() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    JobServices jobServices = JobServices();

    List<Job> jobs = await jobServices.getFeaturedJob(user.id);
    setState(() {
      featuredJobs = jobs;
    });
  }
  //
  // void getRecentData() async {
  //   final user = Provider.of<UserProvider>(context, listen: false).user;
  //   JobServices jobServices = JobServices();
  //
  //   // Fetch recent jobs based on userId or any other criteria
  //   List<Job> jobs = await jobServices.get(user.id); // Assume this method exists
  //   setState(() {
  //     recentJobs = jobs;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            return false;
          },
          child: SingleChildScrollView(
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
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
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
                        _buildCategoryChip("Full Time"),
                        _buildCategoryChip("Part Time"),
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
                  Container(
                    height: 175, // Set height for horizontal job cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredJobs.length,
                      itemBuilder: (context, index) {
                        return JobCard(
                            job: featuredJobs[index]); // Pass job data
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Recent Jobs Section
                  Text(
                    "Recent Jobs",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recentJobs.length,
                    itemBuilder: (context, index) {
                      // return RecentJobCard(job: recentJobs[index]); // Pass job data
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostJobPage(),
            ),
          );
        },
        backgroundColor:
            Colors.black, // Set the color for the floating action button
        child: Icon(Icons.add),
      ),
    );
  }

  // Category Chip Widget
  Widget _buildCategoryChip(String label) {
    return GestureDetector(
      onTap: () {
        JobServices jobServices = JobServices();
        jobServices.getCategoryJob(label); // Fetch category jobs on tap
      },
      child: Container(
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
      ),
    );
  }
}
