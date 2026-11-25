import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

import '../models/experience.dart';
import '../services/api_client.dart';
import '../services/auth_state.dart';
import '../widgets/auth_guard.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _organization = "";
  String _description = "";
  String _category = "full-time";
  String _thumbnail = "";

  DateTime? _startedAt;
  DateTime? _endedAt;

  bool _isSubmitting = false;

  final Map<String, String> _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  // ubah DateTime menjadi YYYY-MM-DD
  String _formatDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  // tampilkan kalender untuk memilih tanggal
  Future<void> _selectDate(bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: (isStartDate ? _startedAt : _endedAt) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (!mounted || pickedDate == null) return;

    setState(() {
      if (isStartDate) {
        _startedAt = pickedDate;
      } else {
        _endedAt = pickedDate;
      }
    });
  }

  // kirim data Experience ke Django
  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    final startedAt = _startedAt;
    final endedAt = _endedAt;

    // validasi tanggal mulai
    if (startedAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a start date.')),
      );
      return;
    }

    // validasi urutan tanggal
    if (endedAt != null && endedAt.isBefore(startedAt)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date cannot be earlier than start date.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // pastiin pengguna sudah login
      final loggedIn = await ensureLoggedIn(context);

      if (!mounted || !loggedIn) return;

      final token = context.read<AuthState>().token;

      if (token == null) return;

      // buat object Experience dari data form
      final newExperience = Experience(
        title: _title.trim(),
        organization: _organization.trim(),
        description: _description.trim(),
        category: _category,
        thumbnail: _thumbnail.trim(),
        startedAt: _formatDate(startedAt),
        endedAt: endedAt == null ? null : _formatDate(endedAt),
      );

      // kirim data menggunakan POST
      await context.read<ApiClient>().createExperience(
        newExperience,
        token: token,
      );

      if (!mounted) return;

      // dialog hanya muncul jika POST berhasil
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Experience Saved'),
            content: Text('$_title has been successfully saved!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;

      // tokan sudah tidak valid
      if (e.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } catch (_) {
          // token lokal tetap dibersihkan.
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );

        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save experience (${e.statusCode}).'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to connect to server.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Experience Form'),
        backgroundColor: const Color(0xFF8D70B5),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Title ===
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Experience Title",
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    _title = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title cannot be empty!";
                    }

                    if (value.length > 255) {
                      return "Title cannot exceed 255 characters!";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // === Organization ===
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Organization or Company",
                    labelText: "Organization",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    _organization = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Organization cannot be empty!";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // === Description ===
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Describe your experience",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    _description = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description cannot be empty!";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // === Category ===
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _categories.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _category = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),

                // === Thumbnail URL ===
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "https://example.com/image.jpg",
                    labelText: "Thumbnail URL (Optional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    _thumbnail = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }

                    final uri = Uri.tryParse(value.trim());

                    if (uri == null ||
                        !uri.hasAuthority ||
                        (uri.scheme != 'http' && uri.scheme != 'https')) {
                      return "Please enter a valid URL!";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // === Start Date ===
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Start Date'),
                  subtitle: Text(
                    _startedAt == null
                        ? 'Select start date'
                        : _formatDate(_startedAt!),
                  ),
                  onTap: () => _selectDate(true),
                ),

                // === End Date ===
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('End Date (Optional)'),
                  subtitle: Text(
                    _endedAt == null ? 'Present' : _formatDate(_endedAt!),
                  ),
                  onTap: () => _selectDate(false),
                  trailing: _endedAt == null
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _endedAt = null;
                            });
                          },
                        ),
                ),

                const SizedBox(height: 24),

                // === Save Button ===
                Center(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8D70B5),
                      foregroundColor: Colors.white,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
