import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/vocabulary_screen.dart';
import 'screens/grammar_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/favorite_screen.dart';

void main() {
  runApp(
    const ProviderScope( // BẮT BUỘC để Riverpod hoạt động
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Học Tiếng Anh',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/vocabulary': (context) =>  VocabularyScreen(),
        '/grammar': (context) => const GrammarScreen(),
        '/quiz': (context) =>  QuizScreen(),
        '/favorites': (context) => const FavoriteScreen(),
      },
    );
  }
}
