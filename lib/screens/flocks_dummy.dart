import 'package:first_app/data/dummy_data.dart';
import 'package:first_app/models/flock_dummy.dart';
import 'package:first_app/models/vibe.dart';
import 'package:first_app/screens/flock.dart';
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
  final List<Flock> _flockItems = dummyFlocks;
  final List<Vibe> _vibeItems = dummyVibes;

  final url =
      Uri.parse('http://10.0.2.2:3000/api/flocks/paging?take=10&skip=0');
  void getData() async {
    final response = await http.get(url);
    var data = json.decode(response.body);
    print(data);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _flockItems.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(_flockItems[index].id),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => FlockScreen(
                  flock: _flockItems[index],
                ),
              ));
            },
            child: FlockItem(flock: _flockItems[index]),
          ),
        );
      },
    );

    return content;
  }
}
