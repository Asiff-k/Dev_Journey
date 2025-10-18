import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/course_category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  void _getUserName() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final fullName = user.userMetadata?['full_name'] as String?;
      if (fullName != null && fullName.isNotEmpty) {
        setState(() {
          _userName = fullName.split(' ')[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _userName == 'User' ? 'User' : _userName;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
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
    );
  }

  Widget _buildHeader(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        'Hi, $name 👋',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
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
                  value: 0.45,
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withAlpha((0.3 * 255).toInt()),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const Center(
                  child: Text('45%', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(String displayName) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _buildCategoryCard(
          icon: Icons.code,
          title: 'Web Development',
          courseCount: '5 Courses',
          color: Colors.orange,
          displayName: displayName,
        ),
        _buildCategoryCard(
          icon: Icons.phone_android,
          title: 'App Development',
          courseCount: '3 Courses',
          color: Colors.purple,
          displayName: displayName,
        ),
        _buildCategoryCard(
          icon: Icons.biotech,
          title: 'AI Engineering',
          courseCount: '4 Courses',
          color: Colors.cyan,
          displayName: displayName,
        ),
        _buildCategoryCard(
          icon: Icons.settings_applications,
          title: 'Software Engineering',
          courseCount: '6 Courses',
          color: Colors.green,
          displayName: displayName,
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String courseCount,
    required Color color,
    required String displayName,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseCategoryScreen(
              categoryTitle: title,
              userName: displayName, // Pass user name to category screen!
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
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(courseCount, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),),
            )
          ],
        ),
      ),
    );
  }
}
