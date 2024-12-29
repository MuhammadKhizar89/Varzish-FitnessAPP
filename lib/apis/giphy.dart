import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  static const String _apiKey = 'F77QfImrFOT92bBFf8mkEbBrdpkh4oUo';
  static Future<String?> fetchGif(String query) async {
    final url =
        'https://api.giphy.com/v1/gifs/search?api_key=$_apiKey&q=$query&limit=1';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      print(response);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'].isNotEmpty) {
          return data['data'][0]['images']['original']['url'];
        } else {
          return null;
        }
      } else {
        throw Exception('Failed to fetch GIF');
      }
    } catch (e) {
      print('Error fetching GIF: $e');
      return null;
    }
  }
}
