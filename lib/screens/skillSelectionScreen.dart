import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:talent_hive/models/jobModel.dart';
import 'package:talent_hive/screens/homeScreen.dart';
import 'package:talent_hive/services/authServices.dart';
import 'package:talent_hive/services/jobServices.dart';

import '../provider/user_provider.dart';

class SkillsSelectionPage extends StatefulWidget {
  late String email;

  @override
  _SkillsSelectionPageState createState() => _SkillsSelectionPageState();
}

class _SkillsSelectionPageState extends State<SkillsSelectionPage> {
  final List<String> _skills = [
    "Flutter",
    "Dart",
    "Python",
    "JavaScript",
    "Java",
    "C++",
    "SQL",
    "HTML/CSS",
    "Kotlin",
    "Swift",
    "React",
    "Node.js",
    "AWS",
    "Docker",
    "Git",
    "Ruby",
    "PHP",
    "TypeScript",
    "Go",
    "Rust",
    "Angular",
    "Vue.js",
    "MongoDB",
    "Firebase",
    "GraphQL",
    "Terraform",
    "Kubernetes",
    "Machine Learning",
    "Data Analysis",
    "UI/UX Design",
    "Figma",
    "Adobe XD",
    "DevOps",
    "Linux",
    "Android",
    "iOS",
    "Spring Boot",
    "ASP.NET",
    "TensorFlow",
    "Pandas",
    "NumPy",
    "Cybersecurity",
    "SQL Server",
    "Oracle",
    "PostgreSQL",
    "Bootstrap",
    "Tailwind CSS",
    "Material UI",
  ];
  @override
  void initState() {
    super.initState();
    AuthService authService = AuthService();
    authService.getUserData(context: context);
  }

  final List<String> _selectedSkills = [];

  final TextEditingController _customSkillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final userId = user.id;
    void setSkill(List<String> skill) async {
      JobServices jobServices = JobServices();
      jobServices.setSkill(skill, userId, context);
    }

    // print("EMAIL IN SKILL: ${widget.email}");
    // print("USER ID in PROVIDER: ${userId}");
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Select Your Skills",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _skills.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _skills.length) {
                      return _buildAddSkillBubble();
                    } else {
                      return _buildSkillBubble(_skills[index]);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("Selected Skills: $_selectedSkills");
          setSkill(_selectedSkills);
          // Navigate to the next screen or perform any action here
        },
        label: Text(
          "Continue",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }

  Widget _buildSkillBubble(String skill) {
    final isSelected = _selectedSkills.contains(skill);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSkills.remove(skill);
          } else {
            _selectedSkills.add(skill);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[800] : Colors.white,
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
            skill,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddSkillBubble() {
    return GestureDetector(
      onTap: () {
        _showAddSkillDialog();
      },
      child: Container(
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
            "+",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddSkillDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add a Custom Skill"),
          content: TextField(
            controller: _customSkillController,
            decoration: InputDecoration(hintText: "Enter skill name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newSkill = _customSkillController.text.trim();
                if (newSkill.isNotEmpty && !_skills.contains(newSkill)) {
                  setState(() {
                    _skills.add(newSkill);
                    _selectedSkills.add(newSkill);
                  });
                }
                _customSkillController.clear();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
