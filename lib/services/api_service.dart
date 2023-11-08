import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:first_app/models/location.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/utils/local_storage.dart';
import 'package:http/http.dart' as http;

import 'package:first_app/constants.dart';
import 'package:first_app/models/flock.dart';

class ApiService {
  static Future<String?> register(
      String email, String password, String firsName, String lastName) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode({
          'firstname': firsName,
          'lastname': lastName,
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

  static Future<String?> login(String email, String password) async {
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
    final String? apiToken = await getStringFromLocalStorage('apiToken');
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

  Future<List<Location>?> getLocationsByNameContains(String pattern) async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final List<Location> loadedItems = [];
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.locationsEndpoint}?name.contains=$pattern');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        List<Location> listData = (json.decode(response.body) as List)
            .map((data) => Location.fromJson(data))
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

  Future<User?> getUserById(int id) async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userByIdEndpoint}$id');

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

  Future<Location?> getLocationById(int id) async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.locationByIdEndpoint}$id');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        Location data = Location.fromJson(json.decode(response.body));
        print(data.name);
        return data;
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<List<Location>?> getLocations() async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final List<Location> loadedItems = [];
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.locationsPagingEndpoint}');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });

      print(response.body);

      if (response.statusCode == 200) {
        List<Location> listData = (json.decode(response.body)['data'] as List)
            .map((data) => Location.fromJson(data))
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

  Future<User?> putUser(int id, Map<String, dynamic> user) async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userByIdEndpoint}$id');
    print(user);
    try {
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $apiToken',
          'Content-type': 'application/json',
        },
        body: json.encode(user),
      );
      print(response.body);
      // print(json.encode(user));
      // if (response.statusCode == 200) {
      //   User data = User.fromJson(json.decode(response.body));
      //   return data;
      // }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  Future<List<Vibe>?> getVibes() async {
    final String? apiToken = await getStringFromLocalStorage('apiToken');
    final List<Vibe> loadedItems = [];
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.vibesEndpoint);

    print(url);

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $apiToken',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        List<Vibe> listData = (json.decode(response.body) as List)
            .map((data) => Vibe.fromJson(data))
            .toList();

        for (final item in listData) {
          loadedItems.add(item);
        }
        print(loadedItems.length);
      }
    } catch (error) {
      log(error.toString());
    }
    return loadedItems;
  }
}
