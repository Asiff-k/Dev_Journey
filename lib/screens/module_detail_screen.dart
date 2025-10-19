import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'module_data.dart';

class ModuleDetailScreen extends StatelessWidget {
  final Module module;
  const ModuleDetailScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(module.title),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Markdown(
          data: module.content,
          styleSheet: MarkdownStyleSheet(
            h2: const TextStyle(color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.bold),
            p: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
