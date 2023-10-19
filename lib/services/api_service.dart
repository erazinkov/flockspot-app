// import 'dart:developer';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:first_app/constants.dart';
import 'package:first_app/models/flock.dart';

class ApiService {
  Future<List<Flock>?> getFlocks() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.flocksEndpoint);
    try {
      final response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${ApiConstants.token}',
        'Content-type': 'application/json',
      });
      final List<Flock> loadedItems = [];
      if (response.statusCode == 200) {
        List<Flock> listData = (json.decode(response.body) as List)
            .map((data) => Flock.fromJson(data))
            .toList();

        for (final item in listData) {
          loadedItems.add(item);
        }
      }
      return loadedItems;
      // if (response.statusCode >= 400) {
      //   setState(() {
      //     _isLoading = false;
      //     _error = 'Failed to add Flock data.';
      //     print(response.body);
      //   });
      // }

      // if (response.body == 'null') {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   return;
      // }

      // setState(() {
      //   _isLoading = false;
      // });
    } catch (error) {
      log(error.toString());
      // setState(() {
      //   _error = 'Something went wrong.';
      // });
    }
  }
}
  //   try {
  //     var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.flocksEndpoint);
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<UserModel> _model = userModelFromJson(response.body);
  //       return _model;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }