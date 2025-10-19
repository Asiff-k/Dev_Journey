import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'favourite_provider.dart';
import 'module_data.dart';
import 'module_detail_screen.dart';

class CourseListScreen extends StatelessWidget {
  final String categoryTitle;
  final String userName;

  const CourseListScreen({
    super.key,
    required this.categoryTitle,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Select the correct module list based on category title
    final List<Module> selectedModules;
    if (categoryTitle == "Web Development") {
      selectedModules = webDevModules;
    } else if (categoryTitle == "App Development") {
      selectedModules = mobileDevModules;
    } else if (categoryTitle == "AI Engineering") {
      selectedModules = AIDevModules;
    } else if (categoryTitle == "Software Engineering") {
      selectedModules = softwareDevModules;
    } else {
      selectedModules = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: selectedModules.isEmpty
          ? const Center(
        child: Text(
          "No modules available for this category.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: selectedModules.length,
        itemBuilder: (context, index) {
          final module = selectedModules[index];
          final isFavorite = favoritesProvider.isFavorite(module);

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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(module);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ModuleDetailScreen(module: module),
                        ),
                      );
                    },
                    child: const Text("Start Learning"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
