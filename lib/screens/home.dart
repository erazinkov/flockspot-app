import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:first_app/models/flock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _addFlock();
  }

  void _addFlock() async {
    final flock = Flock(flockSize: 7);
    print(json.encode(flock.toJson()));
    final url = Uri.parse('http://10.0.2.2:3000/api/flocks');

    try {
      final response = await http.post(url,
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJlZ29ycmF6aW5rb3ZAZ21haWwuY29tIiwicm9sZSI6IlVzZXIiLCJpYXQiOjE2OTc3MjU3MTcsImV4cCI6MTY5NzcyOTMxN30.KohxJ1SdBu-6HVZLGQRPuR7yg_r6k6K_9lGhXVetDrg',
            'Content-type': 'application/json',
          },
          body: json.encode(flock.toJson()));

      if (response.statusCode >= 400) {
        setState(() {
          _isLoading = false;
          _error = 'Failed to add Flock data.';
          print(response.body);
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting another tab!',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
        ],
      ),
    );
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      );
    }

    return content;
  }
}
