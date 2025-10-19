class Module {
  final String title;
  final String duration;
  final String level;
  final String content;

  Module({
    required this.title,
    required this.duration,
    required this.level,
    required this.content,
  });
}

final List<Module> webDevModules = [
  Module(
    title: "HTML & CSS Fundamentals",
    duration: "3 Weeks",
    level: "Beginner",
    content: '''
### HTML & CSS Fundamentals

**Week 1: HTML Basics**
- Introduction to HTML
- Tags, Elements, Attributes
- Lists, Links, Images, Tables

**Week 2: CSS Basics**
- Selectors and Properties
- Colors, Fonts, and Backgrounds
- Box Model, Margins, Padding

**Week 3: Layouts**
- Flexbox and Grid
- Responsive Design
- Mini Project: Personal Portfolio Page
''',
  ),
  Module(
    title: "JavaScript Basics",
    duration: "4 Weeks",
    level: "Beginner",
    content: '''
### JavaScript Basics

**Week 1:** Variables and Data Types  
**Week 2:** Functions and Conditions  
**Week 3:** Loops and Arrays  
**Week 4:** DOM Manipulation & Events  
Project: Interactive To-Do App
''',
  ),
  // Add other modules similarly
];
