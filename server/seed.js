const mongoose = require("mongoose");
const Job = require("./models/jobModel"); // Adjust the path to your Job model if necessary

const jobs = [
  {
    title: "Senior Flutter Developer",
    org: "Tech Solutions Inc.",
    description: "Looking for an experienced Flutter developer to lead our mobile team.",
    imageUrl: "https://example.com/flutter-developer.jpg",
    minSalary: 80000,
    maxSalary: 120000,
    type: "Full Time",
    skill: ["Flutter", "Dart", "Git", "Firebase"]
  },
  {
    title: "Backend Engineer",
    org: "Innovative Softwares",
    description: "Responsible for developing and maintaining server-side logic.",
    imageUrl: "https://example.com/backend-engineer.jpg",
    minSalary: 90000,
    maxSalary: 140000,
    type: "Remote",
    skill: ["Node.js", "Python", "Docker", "MongoDB"]
  },
  {
    title: "Data Scientist",
    org: "DataWorks",
    description: "Analyze and interpret complex data to help companies make decisions.",
    imageUrl: "https://example.com/data-scientist.jpg",
    minSalary: 95000,
    maxSalary: 150000,
    type: "Full Time",
    skill: ["Python", "Machine Learning", "Pandas", "TensorFlow"]
  },
  {
    title: "Frontend Developer",
    org: "Web Creatives",
    description: "Design and develop user-facing features for websites.",
    imageUrl: "https://example.com/frontend-developer.jpg",
    minSalary: 70000,
    maxSalary: 100000,
    type: "Part Time",
    skill: ["JavaScript", "React", "HTML/CSS", "Tailwind CSS"]
  },
  {
    title: "DevOps Engineer",
    org: "CloudMasters",
    description: "Implement CI/CD pipelines and maintain cloud infrastructure.",
    imageUrl: "https://example.com/devops-engineer.jpg",
    minSalary: 110000,
    maxSalary: 160000,
    type: "Full Time",
    skill: ["AWS", "Docker", "Kubernetes", "Terraform"]
  },
  {
    title: "UI/UX Designer",
    org: "Creative Studio",
    description: "Design intuitive and aesthetically pleasing user interfaces.",
    imageUrl: "https://example.com/ui-ux-designer.jpg",
    minSalary: 60000,
    maxSalary: 90000,
    type: "Contract",
    skill: ["Figma", "Adobe XD", "UI/UX Design", "Material UI"]
  },
  {
    title: "Project Manager",
    org: "Agile Systems",
    description: "Manage projects ensuring they meet deadlines and budget requirements.",
    imageUrl: "https://example.com/project-manager.jpg",
    minSalary: 90000,
    maxSalary: 130000,
    type: "Remote",
    skill: ["Agile", "Scrum", "JIRA", "DevOps"]
  },
  {
    title: "iOS Developer",
    org: "MobileFirst",
    description: "Develop cutting-edge iOS applications for various clients.",
    imageUrl: "https://example.com/ios-developer.jpg",
    minSalary: 85000,
    maxSalary: 125000,
    type: "Full Time",
    skill: ["Swift", "iOS", "Git", "Firebase"]
  },
  {
    title: "Cybersecurity Analyst",
    org: "SecureTech",
    description: "Protect organizations from cyber threats and vulnerabilities.",
    imageUrl: "https://example.com/cybersecurity-analyst.jpg",
    minSalary: 100000,
    maxSalary: 145000,
    type: "Full Time",
    skill: ["Python", "Cybersecurity", "Linux", "Networking"]
  },
  {
    title: "Machine Learning Engineer",
    org: "AI Innovators",
    description: "Build and deploy machine learning models for various applications.",
    imageUrl: "https://example.com/ml-engineer.jpg",
    minSalary: 110000,
    maxSalary: 160000,
    type: "Remote",
    skill: ["Python", "TensorFlow", "Pandas", "Data Analysis"]
  },
  {
    title: "Full Stack Developer",
    org: "TechGiant",
    description: "Work on both frontend and backend development for large-scale applications.",
    imageUrl: "https://example.com/fullstack-developer.jpg",
    minSalary: 95000,
    maxSalary: 140000,
    type: "Full Time",
    skill: ["JavaScript", "Node.js", "React", "MongoDB"]
  },
  {
    title: "Quality Assurance Engineer",
    org: "QA Pros",
    description: "Ensure the quality and reliability of software through rigorous testing.",
    imageUrl: "https://example.com/qa-engineer.jpg",
    minSalary: 75000,
    maxSalary: 110000,
    type: "Contract",
    skill: ["JavaScript", "SQL", "Git", "Linux"]
  },
  {
    title: "Blockchain Developer",
    org: "CryptoTech",
    description: "Develop and maintain blockchain-based applications.",
    imageUrl: "https://example.com/blockchain-developer.jpg",
    minSalary: 120000,
    maxSalary: 170000,
    type: "Remote",
    skill: ["JavaScript", "Python", "AWS", "Docker"]
  },
  {
    title: "Systems Administrator",
    org: "Global IT Solutions",
    description: "Manage and maintain IT infrastructure and networks.",
    imageUrl: "https://example.com/sys-admin.jpg",
    minSalary: 80000,
    maxSalary: 110000,
    type: "Full Time",
    skill: ["Linux", "SQL Server", "Git", "Docker"]
  },
  {
    title: "Game Developer",
    org: "Gaming World",
    description: "Create engaging and high-performance video games.",
    imageUrl: "https://example.com/game-developer.jpg",
    minSalary: 85000,
    maxSalary: 130000,
    type: "Full Time",
    skill: ["C++", "Unity", "Git", "SQL"]
  },
  {
    title: "Mobile Developer",
    org: "App Ventures",
    description: "Develop mobile applications for Android and iOS platforms.",
    imageUrl: "https://example.com/mobile-developer.jpg",
    minSalary: 90000,
    maxSalary: 130000,
    type: "Remote",
    skill: ["Flutter", "Dart", "Kotlin", "Swift"]
  },
  {
    title: "Database Administrator",
    org: "DataSafe",
    description: "Manage and maintain database systems for large-scale applications.",
    imageUrl: "https://example.com/db-admin.jpg",
    minSalary: 85000,
    maxSalary: 120000,
    type: "Full Time",
    skill: ["SQL Server", "PostgreSQL", "MongoDB", "Oracle"]
  },
  {
    title: "DevOps Architect",
    org: "Cloud Engineers",
    description: "Design and implement DevOps strategies and architectures.",
    imageUrl: "https://example.com/devops-architect.jpg",
    minSalary: 120000,
    maxSalary: 170000,
    type: "Full Time",
    skill: ["AWS", "Docker", "Kubernetes", "Terraform"]
  },
  {
    title: "Front-End Developer",
    org: "DesignPro",
    description: "Create and maintain user interfaces for web applications.",
    imageUrl: "https://example.com/frontend-developer.jpg",
    minSalary: 70000,
    maxSalary: 100000,
    type: "Part Time",
    skill: ["JavaScript", "React", "HTML/CSS", "Material UI"]
  },
  {
    title: "Cloud Engineer",
    org: "CloudMinds",
    description: "Deploy and manage cloud infrastructures on various platforms.",
    imageUrl: "https://example.com/cloud-engineer.jpg",
    minSalary: 100000,
    maxSalary: 140000,
    type: "Remote",
    skill: ["AWS", "Docker", "Terraform", "Linux"]
  }
];

mongoose.connect("mongodb+srv://ved:admin@talenthive.lvzpxrj.mongodb.net/?retryWrites=true&w=majority&appName=talentHive", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const seedDB = async () => {
  await Job.deleteMany({});
  await Job.insertMany(jobs);
  console.log("Database seeded!");
  mongoose.connection.close();
};

seedDB();
