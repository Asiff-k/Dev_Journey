import 'package:dev_journey/screens/module_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favourite_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteCourses = favoritesProvider.favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Courses'),
      ),
      body: favoriteCourses.isEmpty
          ? const Center(
        child: Text(
          'You have no favorite courses yet.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: favoriteCourses.length,
        itemBuilder: (context, index) {
          final module = favoriteCourses[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                module.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(module.duration),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  favoritesProvider.toggleFavorite(module);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ModuleDetailScreen(module: module),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
