import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryService {
  static Future<String?> fetchDefinition(String word) async {
    final response = await http.get(
      Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['meanings'][0]['definitions'][0]['definition'];
    }
    return null;
  }

  static Future<String?> translateToVietnamese(String word) async {
    final response = await http.get(
      Uri.parse('https://api.mymemory.translated.net/get?q=$word&langpair=en|vi'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['responseData']['translatedText'];
    }
    return null;
  }
}
