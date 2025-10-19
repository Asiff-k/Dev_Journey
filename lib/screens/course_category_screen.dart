import 'package:dev_journey/screens/milestone_screen.dart';
import 'package:flutter/material.dart';

class CourseCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final String userName;
  final List<Map<String, dynamic>> modules;
  final List<String> roadmap;

  const CourseCategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.userName,
    required this.modules,
    required this.roadmap,
  });

  @override
  Widget build(BuildContext context) {
    // Apply default/derived properties to modules for display
    final List<Map<String, dynamic>> displayModules = modules.map((module) {
      return {
        ...module,
        'level': module['level'] ?? 'Beginner',
        'progress': module['progress'] ?? (module['isCompleted'] == true ? 1.0 : 0.0),
      };
    }).toList();

    return Scaffold(
      // backgroundColor applied by theme
      appBar: AppBar(
        title: Text(categoryTitle),
        // Style applied by theme
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: displayModules.length,
        itemBuilder: (context, index) {
          final moduleData = displayModules[index];
          // Pass the original index from the modules list
          final originalIndex = modules.indexWhere((m) => m['title'] == moduleData['title']);
          return _buildCourseCard(context, moduleData, originalIndex);
        },
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> moduleData, int originalIndex) {
    final theme = Theme.of(context); // Get theme

    String buttonText = 'Start Learning';
    VoidCallback? onPressedAction; // Nullable VoidCallback

    final double progress = moduleData['progress'] ?? 0.0;
    final bool isCompleted = progress >= 1.0;

    // Define navigation action separately for clarity
    void navigateToMilestone() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MilestoneScreen(
            courseTitle: categoryTitle,
            userName: userName,
            modules: modules, // Pass original modules list
            roadmap: roadmap,
            currentModuleIndex: originalIndex, // Use original index
          ),
        ),
      );
    }

    if (progress > 0 && !isCompleted) {
      buttonText = 'Continue Learning';
      onPressedAction = navigateToMilestone;
    } else if (isCompleted) {
      buttonText = 'Completed';
      onPressedAction = null; // Disable button
    } else { // progress == 0
      buttonText = 'Start Learning';
      onPressedAction = navigateToMilestone;
    }

    return GestureDetector(
      onTap: navigateToMilestone, // Navigate on tap anywhere on the card
      child: Card( // Use Card themed from main.dart
        // margin handled by CardTheme
        child: Padding( // Add padding inside the card
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start, // Align top
                children: [
                  Expanded(
                    child: Text(
                      moduleData['title'],
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withAlpha(25), // Use theme color alpha
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      moduleData['level'],
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                moduleData['duration'] ?? 'N/A',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]), // Use theme text style
              ),
              const SizedBox(height: 16),
              if (progress > 0) // Show progress bar only if started
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300], // Lighter background
                  valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? Colors.green : theme.primaryColor), // Use theme color
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),

              // Use Align to position button/text consistently
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: isCompleted
                      ? Text( // Show text if completed
                    'Completed',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                      : ElevatedButton( // Show button if not completed
                    onPressed: onPressedAction,
                    child: Text(buttonText),
                    style: ElevatedButton.styleFrom(
                      // Style is mostly handled by theme, but can override if needed
                      // e.g., make it smaller if desired
                      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      // textStyle: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}