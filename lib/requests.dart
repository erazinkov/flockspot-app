import 'dart:convert';
import 'dart:math';
import 'package:first_app/models.dart';
import 'package:http/http.dart' as http;

Random r = Random();

class AlbumService {
  Future<Album> fetchAlbum() async {
    await Future.delayed(const Duration(seconds: 3));
    int n = r.nextInt(9) + 1;
    print('$n');
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$n'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
