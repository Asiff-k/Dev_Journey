import 'package:flutter/material.dart';

class MilestoneScreen extends StatefulWidget {
  final String courseTitle;
  final String userName;

  const MilestoneScreen({
    super.key,
    required this.courseTitle,
    required this.userName,
  });

  @override
  State<MilestoneScreen> createState() => _MilestoneScreenState();
}

class _MilestoneScreenState extends State<MilestoneScreen> {
  final List<Map<String, dynamic>> _milestones = [
    {'title': 'Module 1: HTML Structure', 'duration': '3 Weeks', 'isCompleted': true},
    {'title': 'Module 2: Basic CSS Styling', 'duration': '2 Weeks', 'isCompleted': true},
    {'title': 'Module 3: Responsive Design Principles', 'duration': '2 Weeks', 'isCompleted': false},
    {'title': 'Module 4: JavaScript Fundamentals', 'duration': '3 Weeks', 'isCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(widget.courseTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Your learning path',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: _milestones.length,
                itemBuilder: (context, index) {
                  final milestone = _milestones[index];
                  return _buildMilestoneItem(milestone, index == _milestones.length - 1);
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Keep up the great work, ${widget.userName}!',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Mark as Complete', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: milestone['isCompleted'] ? Colors.green : Colors.white,
                  border: Border.all(
                    color: milestone['isCompleted'] ? Colors.green : Colors.grey,
                    width: 2,
                  ),
                ),
                child: milestone['isCompleted']
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : const Icon(Icons.play_arrow, color: Colors.blue, size: 20),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  milestone['duration'],
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(height: isLast ? 0 : 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
