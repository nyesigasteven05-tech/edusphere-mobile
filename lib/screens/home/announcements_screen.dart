import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildAnnouncementCard(
              title: 'System Maintenance',
              description: 'The system will undergo maintenance on Sunday.',
              date: 'Today',
              icon: Icons.build,
            ),
            const SizedBox(height: 12),
            _buildAnnouncementCard(
              title: 'New Feature Released',
              description: 'Check out the new dashboard features.',
              date: 'Yesterday',
              icon: Icons.lightbulb,
            ),
            const SizedBox(height: 12),
            _buildAnnouncementCard(
              title: 'Important Notice',
              description: 'Please update your profile information.',
              date: '2 days ago',
              icon: Icons.info,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required String title,
    required String description,
    required String date,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppTheme.primaryBlue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
