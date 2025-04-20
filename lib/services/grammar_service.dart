import 'dart:convert';
import 'package:http/http.dart' as http;

class GrammarService {
  static Future<List<Map<String, dynamic>>> fetchGrammar() async {
    final response = await http.get(
      Uri.parse('https://yourapi.com/api/grammar'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => {
        "title": e['title'],
        "explanation": e['explanation'],
        "example": e['example'],
      }).toList();
    }
    return [];
  }
}
