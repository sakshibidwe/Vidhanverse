// lib/category_detail.dart
import 'package:flutter/material.dart';
import 'game_levels.dart'; // Import the GameLevelsScreen

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final String description;

  const CategoryDetailScreen({super.key, required this.category, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildGamifiedContent(context, category),
          ],
        ),
      ),
    );
  }

  Widget _buildGamifiedContent(BuildContext context, String category) {
    return Column(
      children: [
        const Text('Test your knowledge with Duolingo-like game levels.'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameLevelsScreen(category: category),
              ),
            );
          },
          child: const Text('Start Game Levels'),
        ),
        // Add other gamified content here
      ],
    );
  }
}