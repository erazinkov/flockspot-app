import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'models.dart';

Future<Number> getNumber({int num = 20}) async {
  http.Response res =
      await http.get(Uri.http("dummyresponse.pythonanywhere.com", "/api/$num"));
  return Number.fromJSON(json.decode(res.body));
}

Stream<Number> getNumbers(Duration refreshTime) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await getNumber();
  }
}
