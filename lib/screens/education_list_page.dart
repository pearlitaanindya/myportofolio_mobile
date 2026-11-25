import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/education.dart';
import '../services/api_client.dart';
import '../widgets/left_drawer.dart';
import 'education_detail_page.dart';

class EducationListPage extends StatefulWidget {
  const EducationListPage({super.key});

  @override
  State<EducationListPage> createState() => _EducationListPageState();
}

class _EducationListPageState extends State<EducationListPage> {
  late Future<List<Education>> _educationsFuture;

  @override
  void initState() {
    super.initState();
    _educationsFuture = context.read<ApiClient>().getEducations();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getEducations();

    setState(() {
      _educationsFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // Error akan ditampilkan oleh FutureBuilder.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Education')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Education>>(
        future: _educationsFuture,
        builder: (context, snapshot) {
          // kondisi ketika data sedang dimuat
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // kondisi ketika pengambilan data gagal
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load education.'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final educations = snapshot.data ?? const <Education>[];

          // kondisi ketika belum ada data education
          if (educations.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('No education found.')),
                ],
              ),
            );
          }

          // kondisi ketika data berhasil dimuat
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(education.degree),
                    subtitle: Text(
                      '${education.school}\n'
                      'GPA: ${education.gpa ?? "-"}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EducationDetailPage(education: education),
                        ),
                      );
                    },
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
