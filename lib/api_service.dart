import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> postUser(Map<String, dynamic> user) async {
    final url = Uri.https(
        'flutter-chat-app-2618e-default-rtdb.firebaseio.com', 'users.json');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user),
      );
      return response.body;
    } catch (error) {
      print('Something is wrong.');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final url = Uri.https(
        'flutter-chat-app-2618e-default-rtdb.firebaseio.com', 'users.json');

    try {
      var response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (error) {
      print('Something is wrong.');
    }
    return null;
  }

  Future<String?> postMessage(Map<String, dynamic> message) async {
    final url = Uri.https(
        'flutter-chat-app-2618e-default-rtdb.firebaseio.com', 'messages.json');

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(message),
      );
      return response.body;
    } catch (error) {
      print('Something is wrong.');
    }
    return null;
  }
}
