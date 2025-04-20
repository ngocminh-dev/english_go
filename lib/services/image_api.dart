import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageApi {
  static const String _accessKey = '8CfKQb8nKRHGykNzAJH-v8wGdXnehCa6uZNJjcH0JDQ';

  static Future<String?> fetchImageUrl(String query) async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/search/photos?query=$query&client_id=$_accessKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        return results[0]['urls']['small'] as String;
      }
    }
    return null;
  }
}
