import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:first_app/models/user.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:first_app/constants.dart';
import 'package:first_app/models/flock.dart';

class ApiService {
  static Future<String?> authLogin(String email, String password) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body)['access'];
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  static Future<String?> getToken(User user) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body)['access'];
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<List<Flock>?> getFlocks() async {
    final String? apiToken =
        await LocalStorage.getStringFromLocalStorage('apiToken');
    final List<Flock> loadedItems = [];
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.flocksEndpoint);

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        List<Flock> listData = (json.decode(response.body)['data'] as List)
            .map((data) => Flock.fromJson(data))
            .toList();

        for (final item in listData) {
          loadedItems.add(item);
        }
      }
    } catch (error) {
      log(error.toString());
    }
    return loadedItems;
  }

  Future<User?> getUser(int id) async {
    final String? apiToken =
        await LocalStorage.getStringFromLocalStorage('apiToken');
    final url =
        Uri.parse('ApiConstants.baseUrl + ApiConstants.userByIdEndpoint + $id');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        User data = User.fromJson(json.decode(response.body));
        return data;
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }
}
