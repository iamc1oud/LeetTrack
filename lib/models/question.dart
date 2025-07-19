import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)
class Question extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String topicId;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late String? link;

  @HiveField(5)
  late String? pseudoCode;

  @HiveField(6)
  late DateTime createdAt;

  @HiveField(7)
  late bool isFavorite;

  @HiveField(8)
  late String? notes;

  @HiveField(9)
  late DifficultyLevel difficulty;

  Question({
    required this.id,
    required this.topicId,
    required this.title,
    required this.description,
    this.link,
    this.pseudoCode,
    DateTime? createdAt,
    this.isFavorite = false,
    this.notes,
    this.difficulty = DifficultyLevel.medium,
  }) : createdAt = createdAt ?? DateTime.now();
}

@HiveType(typeId: 2)
enum DifficultyLevel {
  @HiveField(0)
  easy,

  @HiveField(1)
  medium,

  @HiveField(2)
  hard,
}