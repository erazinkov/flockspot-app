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

  void _addItem() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/vibes');
    final v = Vibe(
      name: 'Singing',
      status: VibeStatus.Approved,
      icon: 'string',
    );

    final response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: json.encode(v.toJson()));
    print(response.body);
    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    _addItem();
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
