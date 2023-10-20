import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:first_app/constants.dart';
import 'package:first_app/models/flock.dart';

class ApiService {
  Future<List<Flock>?> getFlocks() async {
    final List<Flock> loadedItems = [];
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.flocksEndpoint);
    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${ApiConstants.token}',
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
}
