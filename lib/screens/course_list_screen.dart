import 'package:flutter/material.dart';

import 'module_data.dart';
import 'module_detail_screen.dart';

class CourseListScreen extends StatelessWidget {
  final String categoryTitle;
  final String userName;
  const CourseListScreen({super.key, required this.categoryTitle, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(categoryTitle),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: webDevModules.length,
        itemBuilder: (context, index) {
          final module = webDevModules[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                "Module ${index + 1}: ${module.title}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(module.duration),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModuleDetailScreen(module: module),
                    ),
                  );
                },
                child: const Text("Start Learning"),
              ),
            ),
          );
        },
      ),
    );
  }
}
