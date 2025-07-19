import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/database_service.dart';

class AddQuestionScreen extends StatefulWidget {
  final String topicId;
  final Question? question;

  const AddQuestionScreen({
    super.key,
    required this.topicId,
    this.question,
  });

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = TextEditingController();
  final _pseudoCodeController = TextEditingController();
  final _notesController = TextEditingController();
  
  DifficultyLevel _selectedDifficulty = DifficultyLevel.medium;
  final DatabaseService _databaseService = DatabaseService();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.question != null;
    
    if (_isEditing) {
      _titleController.text = widget.question!.title;
      _descriptionController.text = widget.question!.description;
      _linkController.text = widget.question!.link ?? '';
      _pseudoCodeController.text = widget.question!.pseudoCode ?? '';
      _notesController.text = widget.question!.notes ?? '';
      _selectedDifficulty = widget.question!.difficulty;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    _pseudoCodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Question' : 'Add Question'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Question Title',
                  hintText: 'e.g., Two Sum, Merge Intervals',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Brief description of the problem',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _linkController,
                decoration: const InputDecoration(
                  labelText: 'Problem Link (Optional)',
                  hintText: 'e.g., https://leetcode.com/problems/two-sum/',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              _buildDifficultySelector(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pseudoCodeController,
                decoration: const InputDecoration(
                  labelText: 'Pseudocode / Solution (Optional)',
                  hintText: 'Add your solution approach or pseudocode',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  hintText: 'Any additional notes or tips',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _saveQuestion,
                  child: Text(_isEditing ? 'Update Question' : 'Add Question'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Difficulty Level'),
        const SizedBox(height: 8),
        SegmentedButton<DifficultyLevel>(
          segments: const [
            ButtonSegment<DifficultyLevel>(
              value: DifficultyLevel.easy,
              label: Text('Easy'),
              icon: Icon(Icons.sentiment_satisfied),
            ),
            ButtonSegment<DifficultyLevel>(
              value: DifficultyLevel.medium,
              label: Text('Medium'),
              icon: Icon(Icons.sentiment_neutral),
            ),
            ButtonSegment<DifficultyLevel>(
              value: DifficultyLevel.hard,
              label: Text('Hard'),
              icon: Icon(Icons.sentiment_very_dissatisfied),
            ),
          ],
          selected: {_selectedDifficulty},
          onSelectionChanged: (Set<DifficultyLevel> newSelection) {
            setState(() {
              _selectedDifficulty = newSelection.first;
            });
          },
        ),
      ],
    );
  }

  Future<void> _saveQuestion() async {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        // Update existing question
        widget.question!.title = _titleController.text.trim();
        widget.question!.description = _descriptionController.text.trim();
        widget.question!.link = _linkController.text.trim().isEmpty ? null : _linkController.text.trim();
        widget.question!.pseudoCode = _pseudoCodeController.text.trim().isEmpty ? null : _pseudoCodeController.text.trim();
        widget.question!.notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim();
        widget.question!.difficulty = _selectedDifficulty;
        
        await _databaseService.updateQuestion(widget.question!);
      } else {
        // Add new question
        await _databaseService.addQuestion(
          topicId: widget.topicId,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          link: _linkController.text.trim().isEmpty ? null : _linkController.text.trim(),
          pseudoCode: _pseudoCodeController.text.trim().isEmpty ? null : _pseudoCodeController.text.trim(),
          difficulty: _selectedDifficulty,
        );
      }
      
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }
}