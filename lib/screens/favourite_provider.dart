
import 'package:flutter/material.dart';
import 'package:dev_journey/screens/module_data.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Module> _favoriteCourses = [];

  List<Module> get favoriteCourses => _favoriteCourses;

  bool isFavorite(Module module) {
    return _favoriteCourses.contains(module);
  }

  void toggleFavorite(Module module) {
    if (isFavorite(module)) {
      _favoriteCourses.remove(module);
    } else {
      _favoriteCourses.add(module);
    }
    notifyListeners();
  }
}
