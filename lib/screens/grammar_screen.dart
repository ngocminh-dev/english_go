import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({Key? key}) : super(key: key);

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  List<dynamic> _grammarList = [];
  List<dynamic> _filteredList = [];
  bool _isLoading = true;
  String _selectedLevel = 'Beginner';

  @override
  void initState() {
    super.initState();
    loadGrammarData();
  }

  Future<void> loadGrammarData() async {
    final String response = await rootBundle.loadString('assets/data/grammar.json');
    final data = json.decode(response);
    setState(() {
      _grammarList = data;
      filterByLevel();
      _isLoading = false;
    });
  }

  void filterByLevel() {
    _filteredList = _grammarList
        .where((item) => item['level'] == _selectedLevel)
        .toList();
  }

  void showGrammarDetail(Map<String, dynamic> grammar) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(grammar['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Giải thích:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(grammar['explanation']),
            const SizedBox(height: 16),
            Text("Ví dụ:", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('"${grammar['example']}"', style: const TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Đóng"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngữ pháp tiếng Anh theo cấp độ'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ToggleButtons(
              isSelected: [
                _selectedLevel == 'Beginner',
                _selectedLevel == 'Intermediate',
                _selectedLevel == 'Advanced',
              ],
              onPressed: (index) {
                setState(() {
                  _selectedLevel = ['Beginner', 'Intermediate', 'Advanced'][index];
                  filterByLevel();
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Theme.of(context).primaryColor,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Beginner'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Intermediate'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Advanced'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredList.isEmpty
                ? const Center(child: Text("Không có dữ liệu cho cấp độ này."))
                : ListView.builder(
              itemCount: _filteredList.length,
              itemBuilder: (context, index) {
                final grammar = _filteredList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(grammar['title']),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => showGrammarDetail(grammar),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
