import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

import '../models/education.dart';
import '../services/api_client.dart';
import '../services/auth_state.dart';
import '../widgets/auth_guard.dart';
import 'education_list_page.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _degree = "";
  String _school = "";
  String _gpa = "";
  String _thumbnail = "";

  DateTime? _startedAt;
  DateTime? _endedAt;

  bool _isSubmitting = false;

  final _startController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  // format tanggal untuk tampilan form
  String _formatDate(DateTime? date) {
    if (date == null) return "Present";
    return "${date.day}/${date.month}/${date.year}";
  }

  // format tanggal untuk dikirim ke Django
  String _formatApiDate(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  // tampilkan kalender untuk memilih tanggal
  Future<void> _selectDate(bool isStart) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startedAt ?? DateTime.now())
          : (_endedAt ?? _startedAt ?? DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (!mounted || selectedDate == null) return;

    setState(() {
      if (isStart) {
        _startedAt = selectedDate;
        _startController.text = _formatDate(selectedDate);
      } else {
        _endedAt = selectedDate;
        _endController.text = _formatDate(selectedDate);
      }
    });
  }

  // kirim data Education ke Django
  Future<void> _submit() async {
    if (_isSubmitting) return;

    // validasi seluruh input form
    if (!_formKey.currentState!.validate()) return;

    final startedAt = _startedAt;
    final endedAt = _endedAt;

    if (startedAt == null) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // pastikan pengguna sudah login
      final loggedIn = await ensureLoggedIn(context);

      if (!mounted || !loggedIn) return;

      // ambil token dari AuthState
      final token = context.read<AuthState>().token;

      if (token == null) return;

      // buat object Education dari data form
      final newEducation = Education(
        degree: _degree.trim(),
        school: _school.trim(),
        gpa: _gpa.trim().isEmpty ? null : _gpa.trim(),
        thumbnail: _thumbnail.trim(),
        startedAt: _formatApiDate(startedAt),
        endedAt: endedAt == null ? null : _formatApiDate(endedAt),
      );

      // kirim data menggunakan POST
      await context.read<ApiClient>().createEducation(
        newEducation,
        token: token,
      );

      if (!mounted) return;

      // dialog hanya muncul jika POST berhasil
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Education Saved'),
            content: Text('$_degree has been successfully saved!'),
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

      // buka daftar Education agar data terbaru langsung muncul
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const EducationListPage()),
      );
    } on ApiException catch (e) {
      if (!mounted) return;

      // token sudah tidak valid
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
            content: Text('Failed to save education (${e.statusCode}).'),
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
        title: const Text('Add Education Form'),
        backgroundColor: const Color(0xFF8D70B5),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Degree ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Degree",
                  hintText: "e.g. Bachelor of Information Systems",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _degree = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Degree cannot be empty!";
                  }
                  if (value.length > 255) {
                    return "Degree cannot exceed 255 characters!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === School ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "School",
                  hintText: "e.g. Universitas Indonesia",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _school = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "School cannot be empty!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === GPA ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "GPA (Optional)",
                  hintText: "e.g. 3.85",
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return RegExp(r'^\d{0,2}(\.\d{0,2})?$')
                            .hasMatch(newValue.text)
                        ? newValue
                        : oldValue;
                  }),
                ],
                onChanged: (value) {
                  _gpa = value;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }

                  final gpa = double.tryParse(value);

                  if (gpa == null || gpa < 0 || gpa > 99.99) {
                    return "Enter a valid GPA!";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === Thumbnail ===
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Thumbnail URL (Optional)",
                  hintText: "https://example.com/logo.png",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
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
                    return "Enter a valid URL!";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === Start Date ===
              TextFormField(
                controller: _startController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Start Date",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(true),
                validator: (value) {
                  if (_startedAt == null) {
                    return "Start date is required!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === End Date ===
              TextFormField(
                controller: _endController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "End Date (Optional)",
                  hintText: "Leave empty if ongoing",
                  border: const OutlineInputBorder(),
                  suffixIcon: _endedAt == null
                      ? const Icon(Icons.calendar_today)
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _endedAt = null;
                              _endController.clear();
                            });
                          },
                        ),
                ),
                onTap: () => _selectDate(false),
                validator: (value) {
                  if (_endedAt != null &&
                      _startedAt != null &&
                      _endedAt!.isBefore(_startedAt!)) {
                    return "End date cannot be before start date!";
                  }
                  return null;
                },
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
    );
  }
}
