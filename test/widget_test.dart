// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/experience.dart';

void main() {
  test('Experience serializes data correctly', () {
    const experience = Experience(
      title: 'Test Experience',
      organization: 'Test Organization',
      description: 'Test Description',
      category: 'internship',
      startedAt: '2026-11-25',
    );

    final json = experience.toJson();

    expect(json['title'], 'Test Experience');
    expect(json['started_at'], '2026-11-25');
    expect(json.containsKey('id'), isFalse);
  });
}
