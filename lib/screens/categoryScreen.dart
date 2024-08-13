import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talent_hive/services/jobServices.dart';
import '../models/jobModel.dart';
import '../widgets/recentJobCard.dart'; // For Recent Jobs

class CategoryScreen extends StatefulWidget {
  final String categoryType;

  const CategoryScreen({Key? key, required this.categoryType})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Job> categoryJobs = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoryJobs();
  }

  void _fetchCategoryJobs() async {
    JobServices jobServices = JobServices();
    List<Job> jobs =
        await jobServices.getCategoryJob(widget.categoryType, context);
    setState(() {
      categoryJobs = jobs;
    });
  }

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
              // Back Icon and Category Type Heading
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8), // Spacing between icon and text
                  Text(
                    "${widget.categoryType} Jobs",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Job List
              categoryJobs.isEmpty
                  ? Center(
                      child: Text(
                        "No Jobs Found",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: categoryJobs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: RecentJobCard(
                              job: categoryJobs[index],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
