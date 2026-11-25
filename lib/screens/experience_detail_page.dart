import 'package:flutter/material.dart';

import '../config.dart';
import '../models/experience.dart';

class ExperienceDetailPage extends StatelessWidget {
  const ExperienceDetailPage({super.key, required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(experience.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (experience.thumbnail.isNotEmpty)
              Image.network(
                Uri.parse(apiBaseUrl).resolve(experience.thumbnail).toString(),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 100);
                },
              ),
            const SizedBox(height: 16),
            Text(
              experience.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Organization: ${experience.organization}'),
            Text('Category: ${experience.category}'),
            Text('Start date: ${experience.startedAt}'),
            Text('End date: ${experience.endedAt ?? "Present"}'),
            const SizedBox(height: 16),
            Text(experience.description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 8),
                Text('${experience.starCount} stars'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
