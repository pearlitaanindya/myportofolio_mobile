import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.organization,
    required this.description,
    required this.category,
    required this.startedAt,
    this.endedAt,
    this.thumbnail = '',
    this.isOngoing = false,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String organization;
  final String description;
  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  final String startedAt;
  final String? endedAt;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isOngoing;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
