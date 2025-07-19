import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/topic.dart';
import '../models/question.dart';

class DatabaseService {
  static const String topicsBoxName = 'topics';
  static const String questionsBoxName = 'questions';
  static final DatabaseService _instance = DatabaseService._internal();
  final _uuid = const Uuid();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(TopicAdapter());
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(DifficultyLevelAdapter());
    
    // Open boxes
    await Hive.openBox<Topic>(topicsBoxName);
    await Hive.openBox<Question>(questionsBoxName);
  }

  // Topic operations
  Future<List<Topic>> getAllTopics() async {
    final box = Hive.box<Topic>(topicsBoxName);
    return box.values.toList();
  }

  Future<Topic> addTopic(String name, String description) async {
    final box = Hive.box<Topic>(topicsBoxName);
    final topic = Topic(
      id: _uuid.v4(),
      name: name,
      description: description,
    );
    await box.put(topic.id, topic);
    return topic;
  }

  Future<void> updateTopic(Topic topic) async {
    final box = Hive.box<Topic>(topicsBoxName);
    await box.put(topic.id, topic);
  }

  Future<void> deleteTopic(String topicId) async {
    final topicBox = Hive.box<Topic>(topicsBoxName);
    final questionBox = Hive.box<Question>(questionsBoxName);
    
    // Delete the topic
    await topicBox.delete(topicId);
    
    // Delete all questions associated with this topic
    final questionsToDelete = questionBox.values.where((q) => q.topicId == topicId).toList();
    for (var question in questionsToDelete) {
      await questionBox.delete(question.id);
    }
  }

  // Question operations
  Future<List<Question>> getQuestionsForTopic(String topicId) async {
    final box = Hive.box<Question>(questionsBoxName);
    return box.values.where((question) => question.topicId == topicId).toList();
  }

  Future<Question> addQuestion({
    required String topicId,
    required String title,
    required String description,
    String? link,
    String? pseudoCode,
    DifficultyLevel difficulty = DifficultyLevel.medium,
  }) async {
    final box = Hive.box<Question>(questionsBoxName);
    final question = Question(
      id: _uuid.v4(),
      topicId: topicId,
      title: title,
      description: description,
      link: link,
      pseudoCode: pseudoCode,
      difficulty: difficulty,
    );
    await box.put(question.id, question);
    return question;
  }

  Future<void> updateQuestion(Question question) async {
    final box = Hive.box<Question>(questionsBoxName);
    await box.put(question.id, question);
  }

  Future<void> deleteQuestion(String questionId) async {
    final box = Hive.box<Question>(questionsBoxName);
    await box.delete(questionId);
  }

  Future<void> toggleFavorite(Question question) async {
    question.isFavorite = !question.isFavorite;
    await updateQuestion(question);
  }

  Future<List<Question>> getFavoriteQuestions() async {
    final box = Hive.box<Question>(questionsBoxName);
    return box.values.where((question) => question.isFavorite).toList();
  }
}