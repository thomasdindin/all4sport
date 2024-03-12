import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseIp = "192.168.107";
  final String port = "8000";
  final String baseApiUrl = "/api/";

  final Map<String, String> headers = {
    'Accept': 'application/ld+json',
  };


  //TODO: Changer ça pour avoir le bon ip. Penser à se connecter sur la 107.
  final String dynamicIp = "106";

  ApiService();

  Future<List<dynamic>> get(String table, [int? id]) async {
    try {
      http.Response response;


      if (id == null) {
        response = await http.get(
          Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table"),
          headers: headers,
        );
      } else {
        response = await http.get(
          Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table/$id"),
          headers: headers,
        );
      }

      if (response.statusCode == 200) {
        // Vérifiez si le body est une liste
        var jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData;
        } else if (jsonData is Map && jsonData.containsKey('hydra:member')) {
          // Si le jsonData est une Map et contient la clé 'hydra:member',
          // nous retournons cette liste.
          return jsonData['hydra:member'] as List;
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        throw Exception('Failed to load items');
      }
    } on TimeoutException catch (_) {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }


  Future<void> post(String table, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create item');
      }
    } catch (e) {
      throw Exception('Failed to create item: $e');
    }
  }

  Future<void> put(String table, int id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  Future<void> patch(String table, int id, Map<String, dynamic> data) async {
    try {
      final response = await http.patch(
        Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update item');
      }
    } catch (e) {
      throw Exception('Failed to update item: $e');
    }
  }

  Future<void> delete(String table, int id) async {
    try {
      final response = await http.delete(
        Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl$table/$id"),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }

  Future<bool> postUser(String email, String mdp) async {
    try {
      final response = await http.post(
        Uri.parse("http://$baseIp.$dynamicIp:$port$baseApiUrl/mail"),
        body: jsonEncode({'email': email, 'mdp': mdp}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error posting user: $e');
      return false;
    }
  }

}
