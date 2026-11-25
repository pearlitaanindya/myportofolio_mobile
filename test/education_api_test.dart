import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  // contoh respons JSON dari Django
  final educationJson = {
    'id': 'test-education-id',
    'degree': 'Bachelor of Information Systems',
    'school': 'Universitas Indonesia',
    'gpa': '3.85',
    'thumbnail': null,
    'started_at': '2025-08-25',
    'ended_at': null,
    'is_ongoing': true,
    'star_count': 0,
    'is_starred': false,
    'starred_by_names': '',
  };

  const education = Education(
    degree: 'Bachelor of Information Systems',
    school: 'Universitas Indonesia',
    gpa: '3.85',
    startedAt: '2025-08-25',
  );

  group('Education API Client', () {
    // GET Education tanpa autentikasi
    test('getEducations returns public education list', () async {
      final client = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/api/v1/education/');
        expect(request.headers['authorization'], isNull);

        return http.Response(jsonEncode([educationJson]), 200);
      });

      final api = ApiClient(client: client, baseUrl: 'https://example.com');

      final result = await api.getEducations();

      expect(result.length, 1);
      expect(result.first.degree, education.degree);
      expect(result.first.school, education.school);
      expect(result.first.gpa, '3.85');
      expect(result.first.thumbnail, '');
      expect(result.first.endedAt, isNull);
      expect(result.first.isOngoing, isTrue);
    });

    // GET ketika database kosong
    test('getEducations returns an empty list', () async {
      final client = MockClient((request) async {
        return http.Response('[]', 200);
      });

      final api = ApiClient(client: client, baseUrl: 'https://example.com');

      final result = await api.getEducations();

      expect(result, isEmpty);
    });

    // POST dengan token dan payload yang benar
    test('createEducation sends token and valid JSON', () async {
      final client = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/education/');
        expect(request.headers['authorization'], 'Token test-token');

        final body = jsonDecode(request.body) as Map<String, dynamic>;

        expect(body['degree'], education.degree);
        expect(body['school'], education.school);
        expect(body['gpa'], '3.85');
        expect(body['started_at'], '2025-08-25');
        expect(body['ended_at'], isNull);

        // field read-only tidak boleh dikirim
        expect(body.containsKey('id'), isFalse);
        expect(body.containsKey('is_ongoing'), isFalse);
        expect(body.containsKey('star_count'), isFalse);
        expect(body.containsKey('is_starred'), isFalse);
        expect(body.containsKey('starred_by_names'), isFalse);

        return http.Response(jsonEncode(educationJson), 201);
      });

      final api = ApiClient(client: client, baseUrl: 'https://example.com');

      final result = await api.createEducation(education, token: 'test-token');

      expect(result.id, 'test-education-id');
      expect(result.degree, education.degree);
    });

    // POST dengan token yang tidak valid
    test('createEducation throws ApiException on 401', () async {
      final client = MockClient((request) async {
        return http.Response('{"detail": "Invalid token."}', 401);
      });

      final api = ApiClient(client: client, baseUrl: 'https://example.com');

      await expectLater(
        api.createEducation(education, token: 'invalid-token'),
        throwsA(
          isA<ApiException>().having(
            (error) => error.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
    });

    // GET ketika server mengalami error
    test('getEducations throws ApiException on 500', () async {
      final client = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      final api = ApiClient(client: client, baseUrl: 'https://example.com');

      await expectLater(
        api.getEducations(),
        throwsA(
          isA<ApiException>().having(
            (error) => error.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });
  });
}
