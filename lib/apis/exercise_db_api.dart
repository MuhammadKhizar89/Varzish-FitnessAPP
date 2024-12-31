import 'dart:convert';
import 'dart:io'; // For SocketException
import 'package:http/http.dart' as http;

Future<dynamic> fetchExercisesAPI(int dayNo) async {
  try {
    final url =
        'https://exercisedb.p.rapidapi.com/exercises?limit=10&offset=${dayNo + 10}';
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': 'f976efe201msh14d2053bedc2696p1631a9jsncc1c5a0e0398',
        'x-rapidapi-host': 'exercisedb.p.rapidapi.com',
      },
    );
    final data = json.decode(response.body) as List;
    return data;
  } catch (e) {
    return null;
  }
}
