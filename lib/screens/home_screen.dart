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

// --- Updated Roadmaps ---
const Map<String, List<String>> courseRoadmaps = {
  'Web Development': [
    'Start learning the basics of HTML, CSS, and JavaScript to create simple static websites.',
    'Learn about responsive design to make your websites fit all screen sizes (desktop, tablet, and mobile).',
    'Explore frontend frameworks like React or Vue to build dynamic interfaces.',
    'Understand version control using Git and GitHub for tracking your work.',
    'Learn basic backend development using Node.js or Express.',
    'Get hands-on with databases like MongoDB or MySQL to store data.',
    'Learn about APIs and how frontend connects with backend.',
    'Practice by building real projects and hosting them on Netlify, Vercel, or GitHub Pages.',
    'Master debugging, deployment, and teamwork tools.',
    'Keep learning by exploring full-stack frameworks or advanced tools like Next.js.',
  ],
  'App Development': [
    'Choose your development path: Android (Kotlin or Java), iOS (Swift), Cross-platform (Flutter or React Native).',
    'Learn the programming basics and get familiar with IDE tools like Android Studio or Xcode.',
    'Understand UI design principles and create responsive mobile layouts.',
    'Learn about navigation and user input handling.',
    'Work with local databases like SQLite or Room and connect to REST APIs.',
    'Implement authentication and manage user sessions.',
    'Learn about state management and performance optimization.',
    'Test your app thoroughly, fix bugs, and optimize for different screen sizes.',
    'Prepare your app for deployment on Play Store or App Store.',
    'Maintain the app with regular updates and new features.',
  ],
  'AI Engineering': [
    'Build a strong foundation in Python and mathematics — focus on linear algebra, probability, and statistics.',
    'Learn about data handling with libraries like NumPy, Pandas, and Matplotlib.',
    'Study machine learning algorithms including regression, classification, and clustering.',
    'Practice with scikit-learn to build prediction models.',
    'Move into deep learning with frameworks like TensorFlow or PyTorch.',
    'Explore computer vision (CNNs) and natural language processing (transformers, NLP models).',
    'Learn data preprocessing, feature engineering, and model evaluation techniques.',
    'Work on real-world AI projects such as image recognition, chatbots, or recommendation systems.',
    'Deploy models using tools like Flask, FastAPI, or cloud services (AWS, GCP).',
    'Study AI ethics, bias mitigation, and continuous model improvement.',
  ],
  'Software Engineering': [
    'Learn a core programming language such as Java, Python, or C++.',
    'Master object-oriented programming (OOP) concepts — encapsulation, inheritance, polymorphism.',
    'Study data structures and algorithms for problem-solving and performance optimization.',
    'Understand system design fundamentals — modular design, scalability, and architecture.',
    'Get familiar with databases, REST APIs, and microservices.',
    'Learn version control systems like Git and collaborative coding platforms like GitHub.',
    'Explore software development methodologies such as Agile and Scrum.',
    'Practice testing and debugging techniques.',
    'Participate in team projects and develop code documentation skills.',
    'Contribute to open source or build portfolio projects to demonstrate your expertise.',
  ],
};
// --- End Data for Courses ---


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = ''; // Initialize empty, avoids 'User' flash
  double _overallProgress = 0.0; // Initialize progress to 0.0
  bool _isLoading = true; // Flag to show loading initially

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    if (!mounted) return;
    setState(() { _isLoading = true; });
    await _getUserName();
    await _fetchOverallProgress();
    if (mounted) {
      setState(() { _isLoading = false; });
    }
  }


  Future<void> _getUserName() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final fullName = user.userMetadata?['full_name'] as String?;
        if (fullName != null && fullName.isNotEmpty) {
          _userName = fullName.split(' ')[0]; // Get first name
        } else {
          _userName = 'User'; // Fallback
        }
      } else {
        _userName = 'User'; // Fallback if no user
      }
    } catch (e) {
      print("Error getting user name: $e");
      _userName = 'User'; // Fallback
    }
  }

  Future<void> _fetchOverallProgress() async {
    // **IMPORTANT**: Replace simulation with REAL Supabase query
    await Future.delayed(const Duration(milliseconds: 300));

    int completedModules = 0; // Simulate fetching this count
    int totalModules = courseModules.values.fold(0, (sum, list) => sum + list.length);
    double fetchedProgress = 0.0;

    if (totalModules > 0) {
      // Replace this with your actual DB query result
      fetchedProgress = completedModules / totalModules;
    }
    _overallProgress = fetchedProgress;
  }

  Future<void> _refreshData() async {
    await _loadInitialData();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = _userName;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildHeader(displayName, theme),
              const SizedBox(height: 24),
              _buildProgressCard(theme),
              const SizedBox(height: 24),
              _buildCategoryGrid(displayName, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String name, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        'Hi, ${name.isNotEmpty ? name : 'User'} 👋',
        style: theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProgressCard(ThemeData theme) {
    int progressPercent = (_overallProgress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withAlpha(76),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your learning journey is...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '"One step closer to mastery"',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _overallProgress,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withAlpha(76),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  semanticsLabel: 'Overall learning progress',
                ),
                Center(
                  child: Text(
                    '$progressPercent%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(String displayName, ThemeData theme) {
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
          theme: theme,
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
    required ThemeData theme,
  }) {
    final modules = courseModules[title] ?? [];
    final roadmap = courseRoadmaps[title] ?? []; // Get the correct roadmap

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseCategoryScreen(
              categoryTitle: title,
              userName: displayName,
              modules: modules,
              roadmap: roadmap, // Pass the correct roadmap
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withAlpha(25),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                    courseCount,
                    style: theme.textTheme.labelSmall?.copyWith(
                        color: color, fontWeight: FontWeight.bold
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}