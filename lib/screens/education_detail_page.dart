import 'package:flutter/material.dart';

import '../config.dart';
import '../models/education.dart';

class EducationDetailPage extends StatelessWidget {
  const EducationDetailPage({super.key, required this.education});

  final Education education;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(education.degree)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (education.thumbnail.isNotEmpty)
              Image.network(
                Uri.parse(apiBaseUrl).resolve(education.thumbnail).toString(),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            const SizedBox(height: 16),
            Text(
              education.degree,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('School: ${education.school}'),
            Text('GPA: ${education.gpa ?? "-"}'),
            Text('Start date: ${education.startedAt}'),
            Text('End date: ${education.endedAt ?? "Present"}'),
            Text('Status: ${education.isOngoing ? "Ongoing" : "Completed"}'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8),
                Text('${education.starCount} stars'),
              ],
            ),
            Text(
              'Starred by: ${education.starredByNames.isEmpty ? "-" : education.starredByNames}',
            ),
            Text('Is starred: ${education.isStarred ? "Yes" : "No"}'),
            const SizedBox(height: 16),
            Text('ID: ${education.id ?? "-"}'),
            Text(
              'Thumbnail URL: ${education.thumbnail.isEmpty ? "-" : education.thumbnail}',
            ),
          ],
        ),
      ),
    );
  }
}
