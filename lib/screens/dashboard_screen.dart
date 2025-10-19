import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/course_category_screen.dart';
import 'package:flutter/material.dart';

// --- Data for Courses ---
// Define course data here to pass it down
// In a real app, this might come from a database or a dedicated data service

const Map<String, List<Map<String, dynamic>>> courseModules = {
  'Web Development': [
    {'title': 'Module 1: HTML & CSS Fundamentals', 'duration': '3 Weeks', 'isCompleted': false},
    {'title': 'Module 2: JavaScript Basics', 'duration': '4 Weeks', 'isCompleted': false},
    {'title': 'Module 3: Frontend Frameworks (React Basics)', 'duration': '5 Weeks', 'isCompleted': false},
    {'title': 'Module 4: Backend & Deployment', 'duration': '4 Weeks', 'isCompleted': false},
  ],
  'App Development': [
    {'title': 'Module 1: App Development Basics (Dart/Flutter)', 'duration': '3 Weeks', 'isCompleted': false},
    {'title': 'Module 2: UI Design & Layouts in Flutter', 'duration': '4 Weeks', 'isCompleted': false},
    {'title': 'Module 3: App Logic & State Management', 'duration': '5 Weeks', 'isCompleted': false},
    {'title': 'Module 4: App Publishing & Maintenance', 'duration': '3 Weeks', 'isCompleted': false},
  ],
  'AI Engineering': [
    {'title': 'Module 1: Foundations of AI & ML with Python', 'duration': '4 Weeks', 'isCompleted': false},
    {'title': 'Module 2: Machine Learning Algorithms', 'duration': '5 Weeks', 'isCompleted': false},
    {'title': 'Module 3: Deep Learning & Neural Networks', 'duration': '6 Weeks', 'isCompleted': false},
    {'title': 'Module 4: Deployment & Real-world Applications', 'duration': '4 Weeks', 'isCompleted': false},
  ],
  'Software Engineering': [
    {'title': 'Module 1: Programming Fundamentals & OOP', 'duration': '4 Weeks', 'isCompleted': false},
    {'title': 'Module 2: Data Structures & Algorithms', 'duration': '6 Weeks', 'isCompleted': false},
    {'title': 'Module 3: System Design & Architecture', 'duration': '5 Weeks', 'isCompleted': false},
    {'title': 'Module 4: Software Process & Team Practices', 'duration': '4 Weeks', 'isCompleted': false},
  ],
};

const Map<String, List<String>> courseRoadmaps = {
  'Web Development': [
    'Learn HTML, CSS, and basic web design principles',
    'Master JavaScript and DOM manipulation',
    'Build small projects: portfolios, forms, interactive pages',
    'Learn a framework (React or Vue)',
    'Grasp backend basics (Node.js)',
    'Practice with databases (MongoDB or SQL)',
    'Deploy your projects (GitHub Pages, Vercel, or Netlify)',
  ],
  'App Development': [
    'Pick your platform (Android/iOS/Cross-platform)',
    'Learn programming language (Kotlin, Swift, Dart)',
    'Build simple UI layouts',
    'Connect UIs to app logic',
    'Manage local and remote data',
    'Implement app navigation and user authentication',
    'Test, debug, and publish your app',
  ],
  'AI Engineering': [
    'Master Python and core math (linear algebra, stats)',
    'Learn foundational machine learning methods',
    'Practice with guided machine learning projects',
    'Study deep learning architectures',
    'Complete basic real-world AI projects (e.g. image or text classification)',
    'Experiment with deploying models to the web or cloud',
  ],
  'Software Engineering': [
    'Build programming basics with a language (Java, Python, etc.)',
    'Master OOP concepts and version control',
    'Learn core data structures and algorithms',
    'Collaborate in team projects (using Git)',
    'Study and practice software design patterns',
    'Apply testing and debugging approaches',
    'Explore real-world projects and code reviews',
  ],
};
// --- End Data for Courses ---


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userName = 'User';
  double _overallProgress = 0.0; // Changed from hardcoded 0.45

  @override
  void initState() {
    super.initState();
    _getUserName();
    _fetchOverallProgress(); // Fetch progress on init
  }

  void _getUserName() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final fullName = user.userMetadata?['full_name'] as String?;
      if (fullName != null && fullName.isNotEmpty) {
        setState(() {
          _userName = fullName.split(' ')[0]; // Get first name
        });
      }
    }
  }

  // --- Placeholder for Progress Calculation ---
  // In a real app, this function would query your database (Supabase)
  // to calculate the user's progress based on completed modules/courses.
  Future<void> _fetchOverallProgress() async {
    // Simulate fetching progress (e.g., from Supabase)
    // Replace with your actual Supabase query
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    // --- Example Logic (Replace with actual DB query) ---
    // 1. Get all courses the user is enrolled in.
    // 2. Get all modules for those courses.
    // 3. Get the completion status for each module for this user.
    // 4. Calculate percentage: (completed_modules / total_modules)
    // For now, we'll simulate a value.
    double fetchedProgress = 0.30; // Example: User completed 30%

    // --- End Example Logic ---

    if (mounted) {
      setState(() {
        _overallProgress = fetchedProgress;
      });
    }
  }
  // --- End Placeholder ---

  @override
  Widget build(BuildContext context) {
    // Use `?? 'User'` as a fallback if _userName hasn't loaded yet
    final displayName = _userName;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        child: RefreshIndicator( // Added RefreshIndicator to re-fetch progress
          onRefresh: _fetchOverallProgress,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildHeader(displayName),
              const SizedBox(height: 24),
              _buildProgressCard(),
              const SizedBox(height: 24),
              _buildCategoryGrid(displayName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        // Handle the case where name might still be 'User' initially
        'Hi, ${name.isNotEmpty ? name : 'User'} 👋',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    int progressPercent = (_overallProgress * 100).toInt(); // Calculate percentage

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withAlpha((0.3 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your learning journey is...', style: TextStyle(color: Colors.white, fontSize: 16),),
              SizedBox(height: 4),
              Text('"One step closer to mastery"', style: TextStyle(color: Colors.white70, fontSize: 12),),
            ],
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _overallProgress, // Use the state variable
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withAlpha((0.3 * 255).toInt()),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  semanticsLabel: 'Overall learning progress',
                ),
                Center(
                  child: Text(
                    '$progressPercent%', // Display dynamic percentage
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(String displayName) {
    // Define categories here
    final categories = [
      {'icon': Icons.code, 'title': 'Web Development', 'courseCount': '${courseModules['Web Development']?.length ?? 0} Modules', 'color': Colors.orange},
      {'icon': Icons.phone_android, 'title': 'App Development', 'courseCount': '${courseModules['App Development']?.length ?? 0} Modules', 'color': Colors.purple},
      {'icon': Icons.biotech, 'title': 'AI Engineering', 'courseCount': '${courseModules['AI Engineering']?.length ?? 0} Modules', 'color': Colors.cyan},
      {'icon': Icons.settings_applications, 'title': 'Software Engineering', 'courseCount': '${courseModules['Software Engineering']?.length ?? 0} Modules', 'color': Colors.green},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(
          icon: category['icon'] as IconData,
          title: category['title'] as String,
          courseCount: category['courseCount'] as String,
          color: category['color'] as Color,
          displayName: displayName,
        );
      },
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String courseCount,
    required Color color,
    required String displayName,
  }) {
    // Get the specific modules and roadmap for this category
    final modules = courseModules[title] ?? []; // Use empty list as fallback
    final roadmap = courseRoadmaps[title] ?? []; // Use empty list as fallback

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseCategoryScreen(
              categoryTitle: title,
              userName: displayName,
              modules: modules, // Pass the specific modules
              roadmap: roadmap, // Pass the specific roadmap
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withAlpha((0.1 * 255).toInt()),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2, // Allow title to wrap if needed
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(), // Pushes count to the bottom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                courseCount,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}