import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/flock.dart';
import 'package:first_app/models/location.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/screens/flock.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/widgets/flock_item.dart';
import 'package:first_app/widgets/vibe_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlocksScreen extends StatefulWidget {
  const FlocksScreen({super.key});

  @override
  State<FlocksScreen> createState() => _FlocksScreenState();
}

class _FlocksScreenState extends State<FlocksScreen> {
  var _isLoading = true;
  late List<Flock> _loadedItems = [];

  void _loadItems() async {
    _loadedItems = (await ApiService().getFlocks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _isLoading = false;
        }));

    for (int i = 0; i < _loadedItems[0].users!.length; i++) {
      // 2023-10-03T07:21:13.933Z
      final d = _loadedItems[0].users![i].user.birthdate;
      print(d);
      // print(_loadedItems[0].users![i].user.birthdate);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No items...',
        style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
    if (_isLoading) {
      content = Center(
        child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
      );
    }
    if (_loadedItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _loadedItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_loadedItems[index].id),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => FlockScreen(
                    flock: _loadedItems[index],
                  ),
                ));
              },
              child: FlockItem(flock: _loadedItems[index]),
            ),
          );
        },
      );
    }
    return content;
  }
}
