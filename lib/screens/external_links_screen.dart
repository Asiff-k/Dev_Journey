import 'package:flutter/material.dart';

class ExternalLinksScreen extends StatelessWidget {
  const ExternalLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> externalCourses = [
      {'platform': 'Coursera', 'title': 'Deep Learning Specialization', 'rating': '4.7/5.0', 'icon': Icons.school},
      {'platform': 'freeCodeCamp', 'title': 'Responsive Web Design', 'rating': '4.8/5.0', 'icon': Icons.code},
      {'platform': 'Udemy', 'title': 'Python for Data Science', 'rating': '4.6/5.0', 'icon': Icons.analytics},
      {'platform': 'Coursera', 'title': 'Google IT Support Professional Certificate', 'rating': '4.8/5.0', 'icon': Icons.support_agent},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Learn from Experts'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: externalCourses.length,
        itemBuilder: (context, index) {
          final course = externalCourses[index];
          return _buildExternalCourseCard(context, course);
        },
      ),
    );
  }

  Widget _buildExternalCourseCard(BuildContext context, Map<String, dynamic> course) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(course['icon'], color: Theme.of(context).primaryColor, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['platform'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        course['rating'],
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
