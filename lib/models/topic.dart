import 'package:hive/hive.dart';

part 'topic.g.dart';

@HiveType(typeId: 0)
class Topic extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late DateTime createdAt;

  Topic({
    required this.id,
    required this.name,
    required this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}