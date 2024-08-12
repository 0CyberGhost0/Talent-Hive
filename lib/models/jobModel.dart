class Job {
  String? jobId; // Nullable jobId field
  String title;
  String org;
  String description;
  String imageUrl;
  int minSalary;
  int maxSalary;
  String type;
  List<String> skill;
  int applyCount;
  String location;

  Job({
    this.jobId, // jobId is optional during creation
    required this.title,
    required this.org,
    required this.description,
    required this.imageUrl,
    required this.minSalary,
    required this.maxSalary,
    required this.type,
    required this.skill,
    required this.applyCount,
    required this.location,
  });

  // Create a Job instance from a JSON map
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['_id'], // Fetch the jobId from the '_id' field in MongoDB
      title: json['title'],
      org: json['org'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      minSalary: json['minSalary'].toDouble(),
      maxSalary: json['maxSalary'].toDouble(),
      type: json['type'],
      skill: List<String>.from(json['skill']),
      applyCount: json['applyCount'],
      location: json['location'],
    );
  }

  // Convert a Job instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': jobId, // Include jobId in the JSON map
      'title': title,
      'org': org,
      'description': description,
      'imageUrl': imageUrl,
      'minSalary': minSalary,
      'maxSalary': maxSalary,
      'type': type,
      'skill': skill,
      'applyCount': applyCount,
      'location': location,
    };
  }
}
