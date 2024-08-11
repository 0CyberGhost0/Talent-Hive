class Job {
  String title;
  String org;
  String description;
  String imageUrl;
  int minSalary;
  int maxSalary;
  String type;
  List<String> skill;

  Job({
    required this.title,
    required this.org,
    required this.description,
    required this.imageUrl,
    required this.minSalary,
    required this.maxSalary,
    required this.type,
    required this.skill,
  });

  // Create a Job instance from a JSON map
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'],
      org: json['org'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      minSalary: json['minSalary'].toDouble(),
      maxSalary: json['maxSalary'].toDouble(),
      type: json['type'],
      skill: List<String>.from(json['skill']),
    );
  }

  // Convert a Job instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'org': org,
      'description': description,
      'imageUrl': imageUrl,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'type': type,
      'skill': skill,
    };
  }
}
