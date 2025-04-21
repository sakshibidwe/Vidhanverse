import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'category_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_levels.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _age = 0;
  String _email = '';
  String _mobile = '';
  String _education = '';
  String _university = '';

  int _dailyStreak = 0;
  bool _rewardClaimedToday = false;

  // --- Added for testing ---
  int _testCounter = 0;
  // -----------------------

  @override
  void initState() {
    super.initState();
    _loadStreakData();
  }

  Future<void> _loadStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyStreak = prefs.getInt('dailyStreak') ?? 0;
      _rewardClaimedToday = prefs.getBool('rewardClaimedToday') ?? false;
    });
  }

  Future<void> _saveStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyStreak', _dailyStreak);
    await prefs.setBool('rewardClaimedToday', _rewardClaimedToday);
  }

  void _incrementStreak() {
    setState(() {
      _dailyStreak++;
    });
    _saveStreakData();
  }

  void _claimReward() {
    if (!_rewardClaimedToday) {
      print('Reward claimed! Streak: $_dailyStreak');
      setState(() {
        _rewardClaimedToday = true;
      });
      _saveStreakData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reward already claimed today.')),
      );
    }
  }

  void _showProfileForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Profile Details'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid age';
                      }
                      return null;
                    },
                    onSaved: (value) => _age = int.parse(value!),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email ID'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    onSaved: (value) => _mobile = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Education'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your education';
                      }
                      return null;
                    },
                    onSaved: (value) => _education = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'University Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your university name';
                      }
                      return null;
                    },
                    onSaved: (value) => _university = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(
                      'Name: $_name, Age: $_age, Email: $_email, Mobile: $_mobile, Education: $_education, University: $_university');
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _incrementTestCounter() {
    setState(() {
      _testCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VidhanVerse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showProfileForm(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Law Assistant',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Ask any legal question to our AI assistant.'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to AI chat page
                      },
                      child: const Text('Ask AI'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _buildCategoryCard(
                  context,
                  'Criminal Law',
                  Icons.gavel,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailScreen(
                          category: 'Criminal Law',
                          description:
                          'Explore IPC, CrPC, and more. Learn about offenses, procedures, and punishments.',
                        ),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  context,
                  'Contract Law',
                  Icons.assignment,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailScreen(
                          category: 'Contract Law',
                          description:
                          'Understand agreements, obligations, and remedies. Dive into the Indian Contract Act.',
                        ),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  context,
                  'Constitutional Law',
                  Icons.balance,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailScreen(
                          category: 'Constitutional Law',
                          description:
                          'Learn about the fundamental rights, duties, and structure of the Indian Constitution.',
                        ),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  context,
                  'Property Law',
                  Icons.home,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryDetailScreen(
                          category: 'Property Law',
                          description:
                          'Study real estate, ownership, and transfer of property. Learn about the Transfer of Property Act.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2500,
                      percent: 0.8,
                      center: const Text("80.0%"),
                      barRadius: const Radius.circular(5),
                      progressColor: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    const Text('Completed Lessons'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Game Levels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameLevelsScreen(category: 'General Law'),
                  ),
                );
              },
              child: const Text('Start Law Games'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daily Streaks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Current Streak: $_dailyStreak days'),
                ElevatedButton(
                  onPressed: _rewardClaimedToday ? null : _claimReward,
                  child: Text(_rewardClaimedToday ? 'Claimed' : 'Claim Reward'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementStreak,
              child: const Text('Increment streak'),
            ),
            // --- Added for testing ---
            const SizedBox(height: 20),
            Text(
              'Test Counter: $_testCounter',
              style: const TextStyle(fontSize: 16),
            ),
            // -----------------------
          ],
        ),
      ),
      // --- Added for testing ---
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTestCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // -----------------------
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}