import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

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

  final _startController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Present";
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _selectDate(bool isStart) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startedAt ?? DateTime.now())
          : (_endedAt ?? _startedAt ?? DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
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
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d{0,2}(\.\d{0,2})?$'),
                  ),
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
                decoration: const InputDecoration(
                  labelText: "End Date (Optional)",
                  hintText: "Leave empty if ongoing",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D70B5),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Education Saved'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Degree: $_degree'),
                                  Text('School: $_school'),
                                  Text(
                                    'GPA: ${_gpa.isEmpty ? "Not provided" : _gpa}',
                                  ),
                                  Text(
                                    'Thumbnail: ${_thumbnail.isEmpty ? "Not provided" : _thumbnail}',
                                  ),
                                  Text(
                                    'Start Date: ${_formatDate(_startedAt)}',
                                  ),
                                  Text('End Date: ${_formatDate(_endedAt)}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
