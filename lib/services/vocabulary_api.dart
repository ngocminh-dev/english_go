import 'dart:convert';
import 'package:http/http.dart' as http;

class VocabularyApi {
  static Future<List<String>> fetchWordList() async {
    try {
      final response = await http.get(
        Uri.parse("https://random-word-api.herokuapp.com/word?number=10"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<String>();
      } else {
        throw Exception("Failed to load words");
      }
    } catch (e) {
      print("Error fetching words: \$e");
      return ["Apple", "Book", "Computer", "Flutter", "Developer"];
    }
  }
}
