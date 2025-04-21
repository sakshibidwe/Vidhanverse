// lib/game_levels.dart
import 'package:flutter/material.dart';

class GameLevelsScreen extends StatefulWidget {
  final String category;

  const GameLevelsScreen({super.key, required this.category});

  @override
  _GameLevelsScreenState createState() => _GameLevelsScreenState();
}

class _GameLevelsScreenState extends State<GameLevelsScreen> {
  final int _currentLevel = 1;
  List<Map<String, dynamic>> _levels = [];

  @override
  void initState() {
    super.initState();
    _loadLevels();
  }

  void _loadLevels() {
    // Replace this with your actual level data loading logic
    // This could be from a JSON file, database, or API
    _levels = _generateLevels(widget.category);
  }

  List<Map<String, dynamic>> _generateLevels(String category) {
    // Basic level generation logic (replace with your actual data)
    List<Map<String, dynamic>> levels = [];
    for (int i = 1; i <= 5; i++) {
      levels.add({
        'level': i,
        'title': '$category Level $i',
        'description': 'Questions and challenges for $category Level $i',
      });
    }
    return levels;
  }

  void _startLevel(int level) {
    // Navigate to the level's question/challenge screen
    // Replace with your actual level screen navigation
    print('Starting level $level for ${widget.category}');
    // Example navigation :
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LevelQuestionScreen(level: level, category: widget.category),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Levels'),
      ),
      body: ListView.builder(
        itemCount: _levels.length,
        itemBuilder: (context, index) {
          final level = _levels[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(level['title']),
              subtitle: Text(level['description']),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _startLevel(level['level']),
            ),
          );
        },
      ),
    );
  }
}