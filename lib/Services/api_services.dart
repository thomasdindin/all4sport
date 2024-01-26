import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchItems() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Gérer les erreurs ici
        throw Exception('Failed to load items');
      }
    } catch (e) {
      // Gérer les exceptions ici
      throw Exception('Failed to load items: $e');
    }
  }
}
