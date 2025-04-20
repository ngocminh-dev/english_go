import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    setState(() {
      _questions = [];
      _currentIndex = 0;
      _score = 0;
    });
    final url = Uri.parse('https://opentdb.com/api.php?amount=5&category=9&type=multiple');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _questions = data['results'];
      });
    }
  }

  void checkAnswer(String selected) {
    final correct = _questions[_currentIndex]['correct_answer'];
    setState(() {
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Quiz")),
        body: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    if (_currentIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(title: Text("Quiz")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "🎉 Bạn đã hoàn thành!\nĐiểm số: $_score / ${_questions.length}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    _score = 0;
                  });
                },
                child: Text("🔁 Làm lại bộ câu hỏi này"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: fetchQuiz,
                child: Text("🎲 Làm quiz khác"),
              ),
            ],
          ),
        ),
      );
    }

    final current = _questions[_currentIndex];
    final options = List<String>.from(current['incorrect_answers']);
    options.add(current['correct_answer']);
    options.shuffle();

    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Câu hỏi ${_currentIndex + 1} / ${_questions.length}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              current['question'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ...options.map((opt) => ElevatedButton(
              onPressed: () => checkAnswer(opt),
              child: Text(opt),
            )),
          ],
        ),
      ),
    );
  }
}
