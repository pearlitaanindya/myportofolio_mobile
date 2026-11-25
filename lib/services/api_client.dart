import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/education.dart';
import '../models/experience.dart';

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  // ambil daftar Experience dari Django
  Future<List<Experience>> getExperiences() async {
    final response = await _client.get(
      _uri('/api/v1/experience/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((item) => Experience.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // tambah Experience ke database Django
  Future<Experience> createExperience(
    Experience experience, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/experience/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(experience.toJson()),
    );

    _ensureSuccess(response);

    return Experience.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  // ambil daftar Education dari Django
  Future<List<Education>> getEducations() async {
    final response = await _client.get(
      _uri('/api/v1/education/'),
      headers: const {'Accept': 'application/json'},
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;

    return decoded
        .map((item) => Education.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // tambah Education ke database Django
  Future<Education> createEducation(
    Education education, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/education/'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(education.toJson()),
    );

    _ensureSuccess(response);

    return Education.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  // login untuk mendapatkan token
  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return decoded['token'] as String;
  }

  // logout untuk menghapus token
  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Authorization': 'Token $token'},
    );

    _ensureSuccess(response);
  }

  // periksa keberhasilan request
  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw ApiException(response.statusCode, response.body);
  }
}
