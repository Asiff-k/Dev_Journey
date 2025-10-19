import 'package:flutter/material.dart';
// import 'package:dev_journey/main.dart'; // Import if needed for DB updates

class MilestoneScreen extends StatefulWidget {
  final String courseTitle;
  final String userName;
  final List<Map<String, dynamic>> modules;
  final List<String> roadmap; // Roadmap data is already passed
  final int currentModuleIndex;

  const MilestoneScreen({
    super.key,
    required this.courseTitle,
    required this.userName,
    required this.modules,
    required this.roadmap, // Already here
    required this.currentModuleIndex,
  });

  @override
  State<MilestoneScreen> createState() => _MilestoneScreenState();
}

class _MilestoneScreenState extends State<MilestoneScreen> {
  late List<Map<String, dynamic>> _milestones;
  late int _currentlyFocusedIndex;
  bool _isLoadingUpdate = false;

  @override
  void initState() {
    super.initState();
    _milestones = widget.modules.map((module) => Map<String, dynamic>.from(module)).toList();
    _currentlyFocusedIndex = widget.currentModuleIndex >= 0 && widget.currentModuleIndex < _milestones.length
        ? widget.currentModuleIndex
        : 0;
    for (var module in _milestones) {
      module['isCompleted'] ??= false;
    }
  }

  Future<void> _updateMilestoneCompletion(int index, bool isCompleted) async {
    if (mounted) setState(() => _isLoadingUpdate = true);
    // --- Placeholder for Supabase Update ---
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate DB update
    // --- End Placeholder ---
    if (mounted) setState(() => _isLoadingUpdate = false);
  }

  void _toggleMilestoneCompletion(int index) {
    if (index < 0 || index >= _milestones.length || _isLoadingUpdate) return;

    setState(() {
      final bool currentStatus = _milestones[index]['isCompleted'] ?? false;
      _milestones[index]['isCompleted'] = !currentStatus;

      _updateMilestoneCompletion(index, _milestones[index]['isCompleted']); // Update backend

      if (_milestones[index]['isCompleted']) {
        int nextIncomplete = _milestones.indexWhere(
                (m) => !(m['isCompleted'] ?? false), index + 1);
        _currentlyFocusedIndex = (nextIncomplete != -1) ? nextIncomplete : _milestones.length - 1;
      } else {
        _currentlyFocusedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String buttonText = 'Mark Module as Complete';
    VoidCallback? buttonAction;

    if (_currentlyFocusedIndex >= 0 && _currentlyFocusedIndex < _milestones.length) {
      final currentModule = _milestones[_currentlyFocusedIndex];
      final moduleTitle = currentModule['title'] ?? 'Module';
      if (currentModule['isCompleted'] == true) {
        buttonText = 'Mark \'$moduleTitle\' as Incomplete';
        buttonAction = () => _toggleMilestoneCompletion(_currentlyFocusedIndex);
      } else {
        buttonText = 'Mark \'$moduleTitle\' as Complete';
        buttonAction = () => _toggleMilestoneCompletion(_currentlyFocusedIndex);
      }
    } else {
      bool allComplete = _milestones.every((m) => m['isCompleted'] == true);
      buttonText = allComplete ? 'All Modules Completed!' : 'Select a Module';
      buttonAction = null;
    }
    if (_isLoadingUpdate) {
      buttonAction = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0), // Reduced top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align titles left
          children: [
            Text(
              'Course Modules',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16), // Reduced space
            // --- Modules List ---
            Expanded(
              child: ListView.builder(
                itemCount: _milestones.length,
                itemBuilder: (context, index) {
                  final milestone = _milestones[index];
                  return _buildMilestoneItem(
                    milestone,
                    index,
                    isLast: index == _milestones.length - 1,
                    isFocused: index == _currentlyFocusedIndex,
                    theme: theme,
                  );
                },
              ),
            ),
            // --- Roadmap Section ---
            if (widget.roadmap.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildRoadmapSection(theme), // Call helper to build roadmap
              const SizedBox(height: 20), // Spacing after roadmap
            ],
            // --- Footer Section ---
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 8.0), // Added top padding
              child: Text(
                'Keep up the great work, ${widget.userName}!',
                textAlign: TextAlign.center, // Center text
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ElevatedButton(
                onPressed: buttonAction,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: buttonAction == null ? Colors.grey : theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
                ),
                child: _isLoadingUpdate
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                    : Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for Roadmap Section ---
  Widget _buildRoadmapSection(ThemeData theme) {
    return ExpansionTile( // Makes the roadmap collapsible
      title: Text(
        'Suggested Roadmap',
        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: false, // Start collapsed
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      backgroundColor: Colors.white, // Background when expanded
      collapsedBackgroundColor: Colors.white, // Background when collapsed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Match card style
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      children: widget.roadmap.map((step) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4.0), // Align bullet point
              child: Icon(Icons.check_circle_outline, size: 16, color: theme.primaryColor),
            ),
            Expanded(child: Text(step, style: theme.textTheme.bodyMedium)),
          ],
        ),
      )).toList(),
    );
  }
  // --- End Helper Widget ---


  Widget _buildMilestoneItem(Map<String, dynamic> milestone, int index, {required bool isLast, required bool isFocused, required ThemeData theme}) {
    bool isCompleted = milestone['isCompleted'] ?? false;
    Color focusColor = isFocused ? theme.primaryColorLight.withAlpha(76) : Colors.transparent;

    return InkWell(
      onTap: _isLoadingUpdate ? null : () {
        setState(() { _currentlyFocusedIndex = index; });
      },
      child: Container(
        decoration: BoxDecoration(
          color: focusColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        // Use Margin for spacing between items instead of SizedBox in Column
        margin: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container( // Circle Indicator
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? Colors.green : Colors.white,
                      border: Border.all(
                        color: isFocused ? theme.primaryColor : (isCompleted ? Colors.green : Colors.grey),
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : (isFocused && !isCompleted ? Icon(Icons.play_arrow, color: theme.primaryColor, size: 20) : null),
                  ),
                  if (!isLast)
                    Expanded( // Vertical Line
                      child: Container( width: 2, color: Colors.grey[300] ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded( // Text Content
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        milestone['title'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isFocused ? theme.primaryColorDark : Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        milestone['duration'] ?? 'N/A',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              Checkbox( // Completion Checkbox
                value: isCompleted,
                onChanged: _isLoadingUpdate ? null : (bool? value) {
                  _toggleMilestoneCompletion(index);
                },
                activeColor: Colors.green,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}