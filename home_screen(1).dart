import 'package:flutter/material.dart';
import 'horoscope_screen.dart';
import 'zodiac_browse_screen.dart';
import 'compatibility_screen.dart';
import 'ai_assistant_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _screens = const [
    HoroscopeScreen(),
    ZodiacBrowseScreen(),
    CompatibilityScreen(),
    AiAssistantScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Horoscope'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Zodiac'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Match'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: 'AI Guide'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
