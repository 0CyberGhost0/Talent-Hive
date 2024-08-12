import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_hive/common/colors.dart';
import 'package:talent_hive/services/jobServices.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  _PostJobPageState createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController orgController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController locationController =
      TextEditingController(); // New Location Controller

  String? selectedJobType; // Initially null to show "Job Type"
  List<String> skills = []; // List to store multiple skills

  RangeValues _salaryRange =
      const RangeValues(30000, 120000); // Default salary range

  void postJob() {
    JobServices jobServices = JobServices();
    jobServices.postJob(
      context: context,
      title: titleController.text,
      organization: orgController.text,
      jobType: selectedJobType!,
      description: descriptionController.text,
      skills: skills,
      minSalary: _salaryRange.start.toInt(),
      maxSalary: _salaryRange.end.toInt(),
      applyCount: 0,
      location: locationController.text, // Add location here
    );
  }

  void addSkill() {
    final skill = skillsController.text.trim();
    if (skill.isNotEmpty && !skills.contains(skill)) {
      setState(() {
        skills.add(skill);
        skillsController.clear(); // Clear input after adding
      });
    }
  }

  void removeSkill(String skill) {
    setState(() {
      skills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2,
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Post a Job",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                  fontSize: 37,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Fill in the details below to post a job",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor2,
                  fontSize: 27,
                  height: 1.2,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              CustomTextField("Job Title", titleController, Icons.title),
              CustomTextField(
                  "Organization Name", orgController, Icons.business_outlined),
              CustomTextField("Location", locationController,
                  Icons.location_on_outlined), // Location Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.work_outline, color: Colors.black54),
                      SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedJobType,
                            hint: Text(
                              "Job Type",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 19,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            items: <String>[
                              'Remote',
                              'Full Time',
                              'Part Time',
                              'Contract'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedJobType = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Salary Slider
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.money, color: Colors.black54),
                            SizedBox(width: 8),
                            Text(
                              'Salary',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RangeSlider(
                        values: _salaryRange,
                        min: 0,
                        max: 200000,
                        divisions: 20,
                        labels: RangeLabels(
                          '\$${_salaryRange.start.toInt()}',
                          '\$${_salaryRange.end.toInt()}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _salaryRange = values;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        '\$${_salaryRange.start.toInt()} - \$${_salaryRange.end.toInt()}',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextField("Job Description", descriptionController,
                  Icons.description_outlined,
                  maxLines: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.build_outlined, color: Colors.black54),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: skillsController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Skills (Press Enter to add)',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 19,
                            ),
                          ),
                          onSubmitted: (value) => addSkill(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: buttonColor),
                        onPressed: addSkill,
                      ),
                    ],
                  ),
                ),
              ),
              if (skills.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: skills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        onDeleted: () => removeSkill(skill),
                        deleteIconColor: Colors.red,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black12),
                      );
                    }).toList(),
                  ),
                ),
              SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: postJob,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Post Job",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
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

  Container CustomTextField(
      String hintText, TextEditingController textController, IconData icon,
      {int maxLines = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: TextField(
        controller: textController,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontSize: 19,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
