import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinksScreen extends StatelessWidget {
  const ExternalLinksScreen({super.key});

  Future<void> _launchURL(String urlString, BuildContext context) async { // Added context for Snackbar
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (context.mounted) { // Check if context is still valid
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $urlString')),
          );
        }
      }
    } catch (e) {
      print('Error launching URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching URL: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme

    final List<Map<String, dynamic>> externalResources = [
      {'type': 'course', 'platform': 'Coursera', 'title': 'Deep Learning Specialization', 'rating': '4.7/5.0', 'icon': Icons.school, 'url': 'https://www.coursera.org/specializations/deep-learning'},
      {'type': 'course', 'platform': 'freeCodeCamp', 'title': 'Responsive Web Design Cert.', 'rating': '4.8/5.0', 'icon': Icons.code, 'url': 'https://www.freecodecamp.org/learn/responsive-web-design/'},
      {'type': 'course', 'platform': 'Udemy', 'title': 'Python for Data Science', 'rating': '4.6/5.0', 'icon': Icons.analytics, 'url': 'https://www.udemy.com/topic/python/'},
      {'type': 'course', 'platform': 'Coursera', 'title': 'Google IT Support Certificate', 'rating': '4.8/5.0', 'icon': Icons.support_agent, 'url': 'https://www.coursera.org/professional-certificates/google-it-support'},
      {'type': 'channel', 'platform': 'YouTube', 'title': 'Programming Hero', 'icon': Icons.play_circle_outline_rounded, 'url': 'https://www.youtube.com/c/programminghero'}, // Changed Icon
      {'type': 'channel', 'platform': 'YouTube', 'title': 'Ostad', 'icon': Icons.play_circle_outline_rounded, 'url': 'https://www.youtube.com/channel/UCs5ytUqwsRy1zPGRElhZ38Q'},
      {'type': 'channel', 'platform': 'YouTube', 'title': 'Apna College', 'icon': Icons.play_circle_outline_rounded, 'url': 'https://www.youtube.com/@ApnaCollegeOfficial'},
      {'type': 'channel', 'platform': 'YouTube', 'title': 'Hablu Programmer', 'icon': Icons.play_circle_outline_rounded, 'url': 'https://www.youtube.com/@HabluProgrammer'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn from Experts'),
        // Style from theme
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: externalResources.length,
        itemBuilder: (context, index) {
          final resource = externalResources[index];
          return _buildExternalResourceCard(context, resource, theme); // Pass theme
        },
      ),
    );
  }

  Widget _buildExternalResourceCard(BuildContext context, Map<String, dynamic> resource, ThemeData theme) {
    bool isChannel = resource['type'] == 'channel';
    bool isPlatform = resource['type'] == 'platform';
    bool hasUrl = resource['url'] != null && (resource['url'] as String).isNotEmpty;

    return Card( // Uses CardTheme
      clipBehavior: Clip.antiAlias, // Ensures InkWell ripple stays within card bounds
      child: InkWell(
        onTap: hasUrl ? () => _launchURL(resource['url'], context) : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                  resource['icon'] ?? Icons.link,
                  color: isChannel ? Colors.redAccent : theme.primaryColor, // Use theme color
                  size: 40
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource['platform'],
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]), // Theme style
                    ),
                    const SizedBox(height: 4),
                    Text(
                      resource['title'],
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), // Theme style
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!isChannel && !isPlatform && resource['rating'] != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            resource['rating'],
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54), // Theme style
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (hasUrl)
                Padding( // Add padding so icon isn't touching edge
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}