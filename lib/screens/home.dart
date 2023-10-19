import 'package:first_app/services/api_service.dart';
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
  @override
  void initState() {
    super.initState();
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
    return content;
  }
}
