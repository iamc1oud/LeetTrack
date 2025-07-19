import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/question.dart';
import '../services/database_service.dart';
import 'add_question_screen.dart';

class QuestionDetailScreen extends StatefulWidget {
  final Question question;

  const QuestionDetailScreen({super.key, required this.question});

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.question.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.question.isFavorite ? Colors.red : null,
            ),
            onPressed: () async {
              await _databaseService.toggleFavorite(widget.question);
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddQuestionScreen(
                    topicId: widget.question.topicId,
                    question: widget.question,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Problem'),
            Tab(text: 'Solution'),
            Tab(text: 'Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProblemTab(),
          _buildSolutionTab(),
          _buildNotesTab(),
        ],
      ),
    );
  }

  Widget _buildProblemTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildDifficultyBadge(widget.question.difficulty),
              const SizedBox(width: 8),
              Text(
                'Created: ${_formatDate(widget.question.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(widget.question.description),
          const SizedBox(height: 24),
          if (widget.question.link != null && widget.question.link!.isNotEmpty)
            ElevatedButton.icon(
              onPressed: () => _launchUrl(widget.question.link!),
              icon: const Icon(Icons.link),
              label: const Text('Open Problem Link'),
            ),
        ],
      ),
    );
  }

  Widget _buildSolutionTab() {
    if (widget.question.pseudoCode == null || widget.question.pseudoCode!.isEmpty) {
      return const Center(
        child: Text('No solution added yet'),
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SyntaxView(
        code: widget.question.pseudoCode!,
        syntax: Syntax.DART,
        syntaxTheme: SyntaxTheme.dracula(),
        withZoom: true,
        withLinesCount: true,
      ),
    );
  }

  Widget _buildNotesTab() {
    if (widget.question.notes == null || widget.question.notes!.isEmpty) {
      return const Center(
        child: Text('No notes added yet'),
      );
    }
    
    return Markdown(
      data: widget.question.notes!,
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildDifficultyBadge(DifficultyLevel difficulty) {
    Color color;
    String text;
    
    switch (difficulty) {
      case DifficultyLevel.easy:
        color = Colors.green;
        text = 'Easy';
        break;
      case DifficultyLevel.medium:
        color = Colors.orange;
        text = 'Medium';
        break;
      case DifficultyLevel.hard:
        color = Colors.red;
        text = 'Hard';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }
}