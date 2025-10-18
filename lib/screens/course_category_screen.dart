import 'package:dev_journey/screens/milestone_screen.dart';
import 'package:flutter/material.dart';

class CourseCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final String userName; // <-- Add this line

  const CourseCategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.userName, // <-- Add this line
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> courses = [
      {'title': 'Frontend Basics', 'duration': '3 Weeks', 'level': 'Beginner', 'progress': 0.7,},
      {'title': 'Responsive Design', 'duration': '2 Weeks', 'level': 'Beginner', 'progress': 0.0,},
      {'title': 'JavaScript Essentials', 'duration': '4 Weeks', 'level': 'Intermediate', 'progress': 0.0,},
      {'title': 'React Fundamentals', 'duration': '5 Weeks', 'level': 'Intermediate', 'progress': 0.2,}
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return _buildCourseCard(context, course);
        },
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MilestoneScreen(
              courseTitle: course['title'],
              userName: userName, // <-- Pass userName here!
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(course['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(course['level'], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(course['duration'], style: const TextStyle(color: Colors.grey, fontSize: 14),),
            const SizedBox(height: 16),
            course['progress'] > 0
                ? LinearProgressIndicator(
              value: course['progress'],
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            )
                : Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MilestoneScreen(
                        courseTitle: course['title'],
                        userName: userName, // <-- Pass userName here!
                      ),
                    ),
                  );
                },
                child: const Text('Start Learning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
