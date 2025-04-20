// main.dart
import 'package:english_go/screens/favorite_screen.dart';
import 'package:english_go/screens/grammar_screen.dart';
import 'package:english_go/screens/home_screen.dart';
import 'package:english_go/screens/quiz_screen.dart';
import 'package:english_go/screens/vocabulary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Học Tiếng Anh',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) =>  HomeScreen(),
        '/vocabulary': (context) =>  VocabularyScreen(),
        '/grammar': (context) =>  GrammarScreen(),
        '/quiz': (context) =>  QuizScreen(),
        '/favorites': (context) =>  FavoriteScreen(),
      },
    );
  }
}
